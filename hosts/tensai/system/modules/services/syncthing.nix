{ ... }:

{
  services.syncthing = {
    enable = true;
    user = "user";
    dataDir = "/home/user";
    configDir = "/home/user/.config/syncthing";
    openDefaultPorts = true;
  };
}
