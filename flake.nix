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
          version = "1.8.1"; # see gradle.properties

          src = ./.;

          buildInputs = [
            pkgs.gradle
            pkgs.jdk
          ];

          builder = ./nix-builder.sh; # gradle shadowJar (with internet access)

          installPhase = ''
            mkdir -p $out
            cp build/libs/*-all.jar $out/
          '';

        };
      }
    );
}
