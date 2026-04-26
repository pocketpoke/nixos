{ ... }:

{
  imports = [
    ./docker.nix
    ./ollama.nix
    ./steam.nix
    ./syncthing.nix
    ./tailscale.nix
    ./virtualization.nix
  ];
}
