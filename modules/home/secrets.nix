{ config, lib, pkgs, ... }: {
  sops = {
    defaultSopsFile = ../../secrets/chatterino2-settings.json;
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    secrets.chatterino2-settings = {
      key = "";
      format = "json";
      path =
        if pkgs.stdenv.hostPlatform.isDarwin then
          "${config.home.homeDirectory}/Library/Application Support/chatterino/Settings/settings.json"
        else
          "${config.home.homeDirectory}/.local/share/chatterino/Settings/settings.json";
    };
  };

  home.activation.ensureChatterinoDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${builtins.dirOf config.sops.secrets.chatterino2-settings.path}"
  '';
}
