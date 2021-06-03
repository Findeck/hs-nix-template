{ compiler ? "ghc884" }:

let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  pkgsLinux = import sources.nixpkgs { system = "x86_64-linux"; };

  includes = [ "src"
               "app"
               "test"
               "{{cookiecutter.project_name}}.cabal"
               "Setup.hs"
               "README.md"
               "LICENSE"
             ];

  cleanByPrefixWhiteList = wl: src:
    let prefixLength = builtins.stringLength (toString src) + 1;
        dropPrefix = p: builtins.substring prefixLength 999999 (toString p);
        startsWith = x: s: builtins.substring 0 (builtins.stringLength s) x == s;
        filter = name: _type: builtins.any (startsWith (dropPrefix name)) wl;
    in pkgs.lib.cleanSourceWith {inherit src; inherit filter;};



  myHaskellPackages = pkgs: pkgs.haskell.packages.${compiler}.override {
    overrides = hself: hsuper: {
      "{{cookiecutter.project_name}}" =
        hself.callCabal2nix
          "{{cookiecutter.project_name}}"
          (cleanByPrefixWhiteList includes ./.)
          {};
    };
  };

  shell = (myHaskellPackages pkgs).shellFor {
    packages = p: [
      p."{{cookiecutter.project_name}}"
    ];
    buildInputs = [
      (myHaskellPackages pkgs).haskell-language-server
      pkgs.haskellPackages.cabal-install
      pkgs.haskellPackages.ghcid
      pkgs.haskellPackages.ormolu
      pkgs.haskellPackages.hlint
      pkgs.niv
      pkgs.nixpkgs-fmt
    ];
    withHoogle = true;
  };

  exe = pkgs.haskell.lib.justStaticExecutables ((myHaskellPackages pkgs)."{{cookiecutter.project_name}}");
  exeLinux = pkgsLinux.haskell.lib.justStaticExecutables ((myHaskellPackages pkgsLinux)."{{cookiecutter.project_name}}");

  docker = pkgsLinux.dockerTools.buildImage {
    name = "{{cookiecutter.project_name}}";
    config.Cmd = [ "${exeLinux}/bin/{{cookiecutter.project_name}}" ];
  };
in
{
  inherit shell;
  inherit exe;
  inherit docker;
  inherit myHaskellPackages;
  "{{cookiecutter.project_name}}" = myHaskellPackages."{{cookiecutter.project_name}}";
}
