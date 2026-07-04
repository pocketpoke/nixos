{ inputs, ... }:
let
  hermesFhsPkgs =
    pkgs: with pkgs; [
      nodejs_22
      ripgrep
      git
      openssh
      ffmpeg

      chromium

      python312
      python312Packages.pip
      python312Packages.setuptools
      python312Packages.virtualenv

      gcc
      glibc.dev
      libffi.dev
      zlib.dev
      pkg-config
      gnumake

      bashInteractive
      coreutils
      findutils
      gnugrep
      gnused
      gawk
      curl
      wget
      procps
      which
      file
      diffutils
      patch
      unzip
      gzip
      bzip2
      xz
    ];
in
{
  nixpkgs.overlays = [
    (final: prev: {
      stability-matrix = final.callPackage ./stability-matrix.nix { };
      patchright = final.callPackage ./patchright.nix { };
      twitchlink = final.callPackage ./twitchlink.nix { };
      imgbrd-grabber = final.callPackage ./imgbrd-grabber.nix {
        imgbrd-grabber = prev.imgbrd-grabber;
      };
      hermes-fhs = prev.buildFHSEnv {
        name = "hermes";
        targetPkgs = hermesFhsPkgs;
        multiPkgs = pkgs: [ ];
        profile = ''
          export HERMES_HOME="''${HERMES_HOME:-$HOME/.hermes}"
          export PLAYWRIGHT_BROWSERS_PATH=0
          export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
          export NPM_CONFIG_PREFIX="$HOME/.local"
          export PATH="$HOME/.local/bin:$PATH"
        '';
        runScript = "hermes";
      };
    })
  ];
}
