{
  description = "DVD screensaver in Zig using Raylib";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      dvd-zig = pkgs.callPackage ./nix/default.nix {};
    in {
      packages = {
        inherit dvd-zig;
        default = dvd-zig;
      };
      devShells.default = import ./nix/shell.nix {inherit pkgs;};
    });
}
