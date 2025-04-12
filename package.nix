{
  lib,
  stdenv,
  gradle,
}:
let
self = stdenv.mkDerivation (finalAttrs: {
  pname = "akropolis";
  version = "1.8.1"; # see gradle.properties

  nativeBuildInputs = [
    gradle
  ];

  # if the package has dependencies, mitmCache must be set
  mitmCache = gradle.fetchDeps {
    # inherit (finalAttrs) pname;
    pkg = self;
    data = ./deps.json;
  };

  gradleBuildTask = "shadowJar";

  installPhase = ''
    cp build/libs/*-all.jar $out
  '';

  meta.sourceProvenance = with lib.sourceTypes; [
    fromSource
    binaryBytecode # mitm cache
  ];
});
in
self

