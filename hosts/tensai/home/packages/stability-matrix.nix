{ pkgs }:

let
  pname = "stability-matrix";
  version = "2.15.6";

  src = pkgs.fetchurl {
    url = "https://github.com/LykosAI/StabilityMatrix/releases/download/v${version}/StabilityMatrix-linux-x64.zip";
    sha256 = "sha256-fzF/g5EXn/FwfrK2F7zdKx/PsdocUhtLYEy4Re+kMu8=";
  };

  extractedAppImage = pkgs.stdenvNoCC.mkDerivation {
    name = "${pname}-${version}-extracted-appimage";
    inherit src;
    nativeBuildInputs = [ pkgs.unzip ];
    dontUnpack = true;
    installPhase = ''
      unzip $src
      mkdir -p $out
      cp StabilityMatrix.AppImage $out/
    '';
  };

  desktopItems = pkgs.stdenvNoCC.mkDerivation {
    name = "${pname}-desktop";
    dontUnpack = true;
    dontBuild = true;
    desktopItem = pkgs.makeDesktopItem {
      name = pname;
      exec = "stability-matrix %U";
      icon = "stability-matrix";
      desktopName = "Stability Matrix";
      comment = "Multi-Platform Package Manager and Inference UI for Stable Diffusion.";
      categories = [ "Graphics" ];
      terminal = false;
      startupNotify = true;
    };
    installPhase = ''
      mkdir -p $out/share/applications
      cp $desktopItem/share/applications/*.desktop $out/share/applications/${pname}.desktop
    '';
  };

in
pkgs.appimageTools.wrapType2 rec {
  inherit pname version;

  src = "${extractedAppImage}/StabilityMatrix.AppImage";

  # ← NEW: needed for wrapProgram
  nativeBuildInputs = [ pkgs.makeWrapper ];

  extraPkgs =
    pkgs: with pkgs; [
      icu
      libGL
      libGLU
      libxcrypt-legacy
    ];

  extraInstallCommands = ''
    # Install our custom .desktop file
    install -Dm444 ${desktopItems}/share/applications/${pname}.desktop \
      $out/share/applications/${pname}.desktop

    # Install the icon
    install -Dm444 ${
      pkgs.fetchurl {
        url = "https://lykos.ai/smlogo.svg";
        sha256 = "sha256:0f4hcgzqzp9sqfrjwb4xzipgzmxaq9xzrzmvyfkf3cjsdwn8264g";
      }
    } \
      $out/share/icons/hicolor/scalable/apps/${pname}.svg

    # ← FIX: force the bundled Python to use NixOS certificates
    wrapProgram $out/bin/stability-matrix \
      --set SSL_CERT_FILE "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt" \
      --set NIX_SSL_CERT_FILE "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
  '';

  meta = with pkgs.lib; {
    description = "Multi-Platform Package Manager and Inference UI for Stable Diffusion";
    homepage = "https://github.com/LykosAI/StabilityMatrix";
    license = licenses.agpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "stability-matrix";
  };
}
