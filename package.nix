{ mkDerivation, base, directory, filepath, hpack, lib
, servant-server, text, wai-cli, warp
}:
mkDerivation {
  pname = "latest-system";
  version = "0.2.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base directory filepath servant-server text
  ];
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [ base wai-cli warp ];
  prePatch = "hpack";
  license = "unknown";
}
