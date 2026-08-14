{ pkgs, inputs, ... }:
{
  virtualisation.docker.enable = true;

  services.syncthing = {
    enable = true;
    user = "user";
    dataDir = "/home/user";
    configDir = "/home/user/.config/syncthing";
    openDefaultPorts = true;
  };

  # Keep Hindsight's database system-managed. Its embedded pg0 binary
  # currently requires an ICU ABI unavailable on this NixOS generation.
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;
    ensureDatabases = [ "hindsight" ];
    ensureUsers = [
      {
        name = "user";
        ensureDBOwnership = false;
      }
    ];
    extensions = ps: [ ps.pgvector ];
  };

  # The database must be owned by the Hermes user so Hindsight can create its
  # schema and vector extension without a password or a superuser secret.
  systemd.services.postgresql-setup.postStart = ''
    ${pkgs.postgresql_17}/bin/psql -d postgres -c 'ALTER DATABASE hindsight OWNER TO "user";'
    ${pkgs.postgresql_17}/bin/psql -d hindsight -c 'CREATE EXTENSION IF NOT EXISTS vector;'
  '';

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "user" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      inputs.dw-proton.packages.${pkgs.stdenv.hostPlatform.system}.dw-proton
    ];
  };
}
