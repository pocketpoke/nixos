{ ... }:

{
  xdg.desktopEntries.lm-studio = {
    name = "LM Studio";
    comment = "Use the chat UI or local server to experiment and develop with local LLMs.";
    exec = "lm-studio %U";
    icon = builtins.fetchurl {
      url = "https://lmstudio.ai/_next/static/media/lmstudio-app-logo.11b4d746.webp";
      sha256 = "10lsvg8a3fbbsh0r11inzcpalf99sjfwqr4b0g4ncpdh6gkvmarv";
    };
    terminal = false;
    categories = [ "Development" ];
    startupNotify = true;
  };
}
