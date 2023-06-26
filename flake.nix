{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  outputs = {nixpkgs, self}: {
    packages = nixpkgs.lib.mapAttrs (system: pkgs: rec {
      default = pkgs.haskell.lib.doHaddock (pkgs.haskellPackages.callPackage ./package.nix {});
      hoogle = pkgs.lib.elemAt (default.envFunc {withHoogle = true;}).nativeBuildInputs 0;
      hoogleSelf = pkgs.haskellPackages.hoogleWithPackages (_: [default]);
      ghc = pkgs.haskellPackages.ghcWithPackages (_: [default]);
    }) nixpkgs.legacyPackages;
    devShells = nixpkgs.lib.mapAttrs (system: pkgs: rec {
      default = (pkgs.haskell.lib.compose.addBuildTools [
        pkgs.cabal-install
        pkgs.watchexec
        pkgs.hpack
      ] self.packages.${system}.default).envFunc {};
    }) nixpkgs.legacyPackages;
    apps = nixpkgs.lib.mapAttrs (system: pkgs: {
      hoogle = {
        type = "app";
        program = "${self.packages.${system}.hoogle}/bin/hoogle";
      };
      hoogleSelf = {
        type = "app";
        program = "${self.packages.${system}.hoogleSelf}/bin/hoogle";
      };
      ghci = {
        type = "app";
        program = "${self.packages.${system}.ghc}/bin/ghci";
      };
    }) nixpkgs.legacyPackages;
  };
}
