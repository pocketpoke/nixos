{ pkgs, ... }: {
  xdg.desktopEntries.affinity-v3 = {
    name = "Affinity";
    comment = "Professional creative suite for photo editing, vector design, and publishing (v3 unified app)";
    exec = "affinity-v3 %U";
    icon = pkgs.fetchurl {
      url = "https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/affinity-studio-icon.svg";
      sha256 = "sha256-0ks42ml9zpmg1lf1cj4g3azc3xac7z3fav5bwsd72j7b9hcgl1";
    };
    terminal = false;
    categories = [ "Graphics" ];
    startupNotify = true;
  };

  xdg.desktopEntries.lm-studio = {
    name = "LM Studio";
    comment = "Use the chat UI or local server to experiment and develop with local LLMs.";
    exec = "lm-studio %U";
    icon = pkgs.fetchurl {
      url = "https://lmstudio.ai/_next/static/media/lmstudio-app-logo.11b4d746.webp";
      sha256 = "10lsvg8a3fbbsh0r11inzcpalf99sjfwqr4b0g4ncpdh6gkvmarv";
    };
    terminal = false;
    categories = [ "Development" ];
    startupNotify = true;
  };
}
