{
  python3Packages,
  python3,
  stdenvNoCC,
  makeDesktopItem,
  makeWrapper,
  fetchFromGitHub,
  ffmpeg-full,
  patchright,
  lib,
}:
let
  twitchlink-desktop = stdenvNoCC.mkDerivation {
    name = "twitchlink";
    dontUnpack = true;
    dontBuild = true;
    desktopItem = makeDesktopItem {
      name = "twitchlink";
      exec = "twitchlink %U";
      icon = "twitchlink";
      desktopName = "TwitchLink";
      comment = "Twitch Stream, Video & Clip Downloader/Recorder GUI";
      categories = [ "AudioVideo" ];
      terminal = false;
      startupNotify = true;
    };
    installPhase = ''
      mkdir -p $out/share/applications
      cp $desktopItem/share/applications/*.desktop $out/share/applications/twitchlink.desktop
    '';
  };
in
python3Packages.buildPythonApplication rec {
  pname = "twitchlink";
  version = "3564e3b";

  src = fetchFromGitHub {
    owner = "pocketpoke";
    repo = "TwitchLink";
    rev = "3564e3b";
    sha256 = "sha256-BAIZsN9J3p7YlinXCkdR6shteqIqRc9lV33G9cdTG70=";
  };

  format = "other";

  propagatedBuildInputs = with python3Packages; [
    pyqt6
    pyqt6-webengine
    selenium
    patchright
  ];

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [ ffmpeg-full ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/twitchlink
    cp -r . $out/share/twitchlink/
    chmod +x $out/share/twitchlink/*.py

    install -Dm444 ${twitchlink-desktop}/share/applications/${pname}.desktop \
      $out/share/applications/${pname}.desktop

    install -Dm444 $out/share/twitchlink/resources/icons/icon.svg \
      $out/share/icons/hicolor/scalable/apps/${pname}.svg

    mkdir -p $out/bin
    makeWrapper ${python3}/bin/python $out/bin/twitchlink \
      --add-flags "$out/share/twitchlink/TwitchLink.py" \
      --prefix PATH : "${ffmpeg-full}/bin" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}" \
      --set PYTHONPATH "$out/share/twitchlink:${python3Packages.makePythonPath propagatedBuildInputs}" \
      --chdir "$out/share/twitchlink/"

    runHook postInstall
  '';

  postFixup = ''
    rm $out/share/twitchlink/resources/dependencies/linux/ffmpeg
    ln -sf ${ffmpeg-full}/bin/ffmpeg $out/share/twitchlink/resources/dependencies/linux/ffmpeg
  '';

  meta = with lib; {
    description = "Twitch Stream, Video & Clip Downloader/Recorder GUI";
    homepage = "https://github.com/devhotteok/TwitchLink";
    license = licenses.mit;
    mainProgram = "twitchlink";
    platforms = platforms.linux;
  };
}
