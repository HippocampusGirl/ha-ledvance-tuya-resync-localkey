{
  description = "A basic flake with a shell";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        python = (pkgs.python3.withPackages
          (py: with py; [ pycryptodome requests ]));
      in {
        devShells.default =
          pkgs.mkShell { buildInputs = with pkgs; [ python ]; };
      });
}
