{ mkDerivation, base, directory, filepath, hpack, lib
, servant-server, text, warp
}:
mkDerivation {
  pname = "latest-system";
  version = "0.1.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base directory filepath servant-server text
  ];
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [ base warp ];
  prePatch = "hpack";
  license = "unknown";
  mainProgram = "latest-system";
}
