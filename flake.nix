{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=25.05";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      # overlays = [
      #   (final: prev: {
      #     # Add any custom packages or overrides here
      #   })
      # ];
    };
  in
  {
    packages.${system} = {
      default = pkgs.callPackage ./package.nix {
        acceleration = "rocm"; # or "cuda" or "none"
      };
    };

    # devShells = {
    #   default = pkgs.mkShell {
    #     buildInputs = [ pkgs.git pkgs.cmake ];
    #     shellHook = ''
    #       echo "Welcome to the development shell!"
    #     '';
    #   };
    # };

    # checks = {
    #   default = pkgs.runCommand "check" { } ''
    #     echo "Running checks..."
    #     touch $out
    #   '';
    # };
  };
}
