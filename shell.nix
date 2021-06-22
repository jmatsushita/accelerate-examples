# # shell.nix
# { pkgs ? import <nixpkgs> {} }:

# let
#   hsPkgs = import ./default.nix {};
# in
#   hsPkgs.shellFor {
#     # Include only the *local* packages of your project.
#     packages = ps: with ps; [
#       accelerate-examples
#     ];

#     # Builds a Hoogle documentation index of all dependencies,
#     # and provides a "hoogle" command to search the index.
#     withHoogle = true;

#     # You might want some extra tools in the shell (optional).

#     # Some common tools can be added with the `tools` argument
#     tools = { cabal = "3.2.0.0"; hlint = "2.2.11"; };
#     # See overlays/tools.nix for more details

#     # Some you may need to get some other way.
#     buildInputs = with pkgs.haskellPackages;
#       [ ghcid ];

#     # Prevents cabal from choosing alternate plans, so that
#     # *all* dependencies are provided by Nix.
#     exactDeps = true;
#   }

(import (
  fetchTarball {
    url = "https://github.com/edolstra/flake-compat/archive/99f1c2157fba4bfe6211a321fd0ee43199025dbf.tar.gz";
    sha256 = "0x2jn3vrawwv9xp15674wjz9pixwjyj3j771izayl962zziivbx2"; }
) {
  src =  ./.;
}).shellNix