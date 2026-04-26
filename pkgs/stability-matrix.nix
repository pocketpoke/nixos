{
  fetchurl,
  stdenvNoCC,
  unzip,
  makeDesktopItem,
  appimageTools,
  makeWrapper,
  cacert,
  lib,
}:
let
  pname = "stability-matrix";
  version = "2.15.6";

  src = fetchurl {
    url = "https://github.com/LykosAI/StabilityMatrix/releases/download/v${version}/StabilityMatrix-linux-x64.zip";
    sha256 = "sha256-fzF/g5EXn/FwfrK2F7zdKx/PsdocUhtLYEy4Re+kMu8=";
  };

  extractedAppImage = stdenvNoCC.mkDerivation {
    name = "${pname}-${version}-extracted-appimage";
    inherit src;
    nativeBuildInputs = [ unzip ];
    dontUnpack = true;
    installPhase = ''
      unzip $src
      mkdir -p $out
      cp StabilityMatrix.AppImage $out/
    '';
  };

  desktopItems = stdenvNoCC.mkDerivation {
    name = "${pname}-desktop";
    dontUnpack = true;
    dontBuild = true;
    desktopItem = makeDesktopItem {
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
appimageTools.wrapType2 {
  inherit pname version;
  src = "${extractedAppImage}/StabilityMatrix.AppImage";

  nativeBuildInputs = [ makeWrapper ];

  extraPkgs =
    pkgs: with pkgs; [
      icu
      libGL
      libGLU
      libxcrypt-legacy
    ];

  extraInstallCommands = ''
    install -Dm444 ${desktopItems}/share/applications/${pname}.desktop \
      $out/share/applications/${pname}.desktop

    install -Dm444 ${
      fetchurl {
        url = "https://lykos.ai/smlogo.svg";
        sha256 = "sha256:0f4hcgzqzp9sqfrjwb4xzipgzmxaq9xzrzmvyfkf3cjsdwn8264g";
      }
    } \
      $out/share/icons/hicolor/scalable/apps/${pname}.svg

    wrapProgram $out/bin/stability-matrix \
      --set SSL_CERT_FILE "${cacert}/etc/ssl/certs/ca-bundle.crt" \
      --set NIX_SSL_CERT_FILE "${cacert}/etc/ssl/certs/ca-bundle.crt"
  '';

  meta = with lib; {
    description = "Multi-Platform Package Manager and Inference UI for Stable Diffusion";
    homepage = "https://github.com/LykosAI/StabilityMatrix";
    license = licenses.agpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "stability-matrix";
  };
}
