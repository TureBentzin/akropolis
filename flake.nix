{
  description = "Akropolis Lobby Plugin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem ( # allow build on different systems
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "akropolis";
          version = "1.8.1"; # see gradle.propertiesqq

          src = ./.;

          buildInputs = [
            pkgs.gradle
            pkgs.jdk
          ];

          buildPhase = ''
            gradle shadowJar
          '';

          installPhase = ''
            mkdir -p $out
            cp build/libs/*-all.jar $out/
          '';
        };
      }
    );
}
