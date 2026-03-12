{ ... }:

{
  xdg.desktopEntries.affinity-v3 = {
    name = "Affinity";
    comment = "Professional creative suite for photo editing, vector design, and publishing (v3 unified app)";
    exec = "affinity-v3 %U";
    icon = builtins.fetchurl {
      url = "https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/affinity-studio-icon.svg";
      sha256 = "sha256:0ks42ml9zpmg1lf1cj4g3azclc3xac7z3fav5bwsd72j7b9hcgl1";
    };
    terminal = false;
    categories = [ "Graphics" ];
    startupNotify = true;
  };
}
