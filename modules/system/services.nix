{ pkgs, ... }: {
  virtualisation.docker.enable = true;

  services.ollama = {
    enable = true;
    acceleration = "cuda";
    package = pkgs.ollama-cuda;
    host = "0.0.0.0";
    environmentVariables = {
      OLLAMA_HOST = "0.0.0.0:11434";
      OLLAMA_ORIGINS = "*";
    };
  };

  services.syncthing = {
    enable = true;
    user = "user";
    dataDir = "/home/user";
    configDir = "/home/user/.config/syncthing";
    openDefaultPorts = true;
  };

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "user" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
}
