{
  description = "Package build for accelerate-examples";
  nixConfig.bash-prompt = "\[nix-develop\]$ ";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils #, cuda-local 
            }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system; 
        overlays = [ cudatoolkit legacy_vulkan ]; 
        config.allowUnfree = true; 
        config.allowBroken = true; 
      };
      ghcVersion = "ghc8104";

      legacy_vulkan = (
        final: prev: {
          linuxPackages_4_19' = prev.linuxPackages_4_19.extend (
              finalx: prevx: {
                nvidia_x11_vulkan_beta = prevx.nvidia_x11_vulkan_beta.overrideAttrs (_: {
                  src = prev.fetchurl {
                    url = "https://download.nvidia.com/XFree86/Linux-x86_64/440.100/NVIDIA-Linux-x86_64-440.100.run";
                    sha256 = "ZJaE+rTzexeK+2yuAS5/lzY3fYn6ir38om8koTu6zx8=";
                  };
                });
              }
          );
        });

      gitignore = pkgs.nix-gitignore.gitignoreSourcePure [ ./.gitignore ];

      myHaskellPackages = pkgs.haskell.packages.${ghcVersion}.override (old: {
        overrides = pkgs.lib.composeExtensions (old.overrides or (_: _: {})) 
          (hself: hsuper: {
            accelerate-llvm-native = pkgs.haskell.lib.dontCheck 
              (pkgs.haskellPackages.callHackage "accelerate-llvm-native" "1.3.0.0" {});
            accelerate-llvm-ptx = pkgs.haskell.lib.dontCheck 
              (pkgs.haskellPackages.callHackage "accelerate-llvm-ptx" "1.3.0.0" {});
            accelerate = pkgs.haskell.lib.dontCheck 
              (pkgs.haskellPackages.callHackage "accelerate" "1.3.0.0" {});

            accelerate-examples = pkgs.haskell.lib.overrideCabal pkg (drv: {
              preConfigure = ''
                export CUDA_PATH=${pkgs.cudatoolkit}'';
            });
          });
      });

      pkg = myHaskellPackages.callCabal2nix "accelerate-examples" (gitignore ./.) {};

    in {
      inherit myHaskellPackages pkgs nixpkgs;
      defaultPackage = pkg;
      packages = { inherit pkg; };
      devShell = myHaskellPackages.shellFor { # development environment
        packages = p: [ p.accelerate-examples ];
        nativeBuildInputs = [ pkgs.cudatoolkit_10_2 pkgs.cudatoolkit_10_2.lib pkgs.linuxPackages_4_19'.nvidia_x11_vulkan_beta];
        buildInputs = with pkgs.haskellPackages; [
          cabal-install
          ghcid
          haskell-language-server
          ormolu
          hlint
          pkgs.pkg-config
          pkgs.nixpkgs-fmt
        ];
        withHoogle = false;
      };
      apps.repl = flake-utils.lib.mkApp {
        drv = pkgs.writeShellScriptBin "repl" ''
          confnix=$(mktemp)
          echo "builtins.getFlake (toString $(git rev-parse --show-toplevel))" >$confnix
          trap "rm $confnix" EXIT
          nix repl $confnix
        '';
      };
      # devShell = pkg.env.overrideAttrs (super: {
      #   nativeBuildInputs = with pkgs; super.nativeBuildInputs ++ [
      #     hs.cabal-install
      #     zlib
      #   ];
      # });
    }
  );
}
