{ ... }:

{
  imports = [
    ./docker.nix
    ./ollama.nix
    ./steam.nix
    ./tailscale.nix
    ./virtualization.nix
  ];
}
