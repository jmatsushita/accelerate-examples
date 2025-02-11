# { # Fetch the latest haskell.nix and import its default.nix
#   haskellNix ? import (builtins.fetchTarball "https://github.com/input-output-hk/haskell.nix/archive/master.tar.gz") {}

# # haskell.nix provides access to the nixpkgs pins which are used by our CI,
# # hence you will be more likely to get cache hits when using these.
# # But you can also just use your own, e.g. '<nixpkgs>'.
# # haskellNix.sources.nixpkgs
# # haskellNix.sources.nixpkgs-unstable
# , nixpkgsSrc ? haskellNix.sources.nixpkgs 

# # haskell.nix provides some arguments to be passed to nixpkgs, including some
# # patches and also the haskell.nix functionality itself as an overlay.
# , nixpkgsArgs ? haskellNix.nixpkgsArgs

# # import nixpkgs with overlays
# , pkgs ? import nixpkgsSrc (nixpkgsArgs // { 
#     overlays = [ (self: super: { llvm-config = self.llvm_8; }) ] ++ nixpkgsArgs.overlays;
#   })
# }: pkgs.haskell-nix.project {
#   # 'cleanGit' cleans a source directory based on the files known by git
#   src = pkgs.haskell-nix.haskellLib.cleanGit {
#     name = "haskell-nix-project";
#     src = ./.;
#   };
#   projectFileName = "stack-8.8.yaml";
#   # Specify the GHC version to use.
#   # compiler-nix-name = "ghc8102"; # Not required for `stack.yaml` based projects.
# }
