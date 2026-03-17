{ pkgs }:

let
  patchright = pkgs.python3Packages.buildPythonPackage {
    pname = "patchright";
    version = "1.58.0";

    format = "wheel";

    src = pkgs.fetchurl {
      url = "https://files.pythonhosted.org/packages/ea/86/98d8f42d5186b6864144fb25e21da8aa7cffa5b9d1d76752276610b9ea58/patchright-1.58.0-py3-none-manylinux1_x86_64.whl";
      hash = "sha256-gyvuL+SM+dwHuzsPDQXu6SMgPzSM2YsUwsUV7s4yZzQ=";
    };

    propagatedBuildInputs = with pkgs.python3Packages; [
      greenlet
      pyee
      typing-extensions
    ];

    doCheck = false;

    meta = with pkgs.lib; {
      description = "Patched and undetected version of Playwright";
      homepage = "https://github.com/Kaliiiiiiiiii-Vinyzu/patchright-python";
      license = licenses.asl20;
    };
  };

  desktopItems = pkgs.stdenvNoCC.mkDerivation {
    name = "twitchlink";

    dontUnpack = true;
    dontBuild = true;

    desktopItem = pkgs.makeDesktopItem {
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
pkgs.python3Packages.buildPythonApplication rec {
  pname = "twitchlink";
  version = "3564e3b"; # or extract from git tag/commit if you pin a rev

  src = pkgs.fetchFromGitHub {
    owner = "pocketpoke";
    repo = "TwitchLink";
    rev = "3564e3b";
    sha256 = "sha256-BAIZsN9J3p7YlinXCkdR6shteqIqRc9lV33G9cdTG70=";
  };

  format = "other"; # no setup.py → manual installPhase

  propagatedBuildInputs = with pkgs.python3Packages; [
    pyqt6
    pyqt6-webengine
    selenium
    patchright
  ];

  # Native/runtime deps for QtWebEngine + FFmpeg + GL
  nativeBuildInputs = [ pkgs.makeWrapper ]; # for wrapping the bin

  buildInputs = with pkgs; [
    ffmpeg-full
  ];

  # No buildPhase needed (pure Python)
  dontBuild = true;

  # Install: copy everything + create bin wrapper
  installPhase = ''
    runHook preInstall

    # Copy source tree to $out/share/twitchlink
    mkdir -p $out/share/twitchlink
    cp -r . $out/share/twitchlink/
    chmod +x $out/share/twitchlink/*.py

    # Install our custom .desktop file
    install -Dm444 ${desktopItems}/share/applications/${pname}.desktop \
      $out/share/applications/${pname}.desktop

    # Install the icon (you can also use multiple sizes or .png if you prefer)
    install -Dm444 $out/share/twitchlink/resources/icons/icon.svg \
      $out/share/icons/hicolor/scalable/apps/${pname}.svg

    # Create bin/ wrapper that sets env + runs python
    mkdir -p $out/bin
    makeWrapper ${pkgs.python3}/bin/python $out/bin/twitchlink \
      --add-flags "$out/share/twitchlink/TwitchLink.py" \
      --prefix PATH : "${pkgs.ffmpeg-full}/bin" \
      --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath buildInputs}" \
      --set PYTHONPATH "$out/share/twitchlink:${pkgs.python3Packages.makePythonPath propagatedBuildInputs}" \
      --chdir "$out/share/twitchlink/"

    runHook postInstall
  '';

  postFixup = ''
    # Replace shared libraries FFmpeg with nixpkgs FFmpeg
    rm $out/share/twitchlink/resources/dependencies/linux/ffmpeg
    ln -sf ${pkgs.ffmpeg-full}/bin/ffmpeg $out/share/twitchlink/resources/dependencies/linux/ffmpeg
  '';

  meta = with pkgs.lib; {
    description = "Twitch Stream, Video & Clip Downloader/Recorder GUI";
    homepage = "https://github.com/devhotteok/TwitchLink";
    license = licenses.mit;
    mainProgram = "twitchlink";
    platforms = platforms.linux;
  };
}
