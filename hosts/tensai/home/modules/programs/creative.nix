{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    inputs.affinity-nix.packages.${stdenv.hostPlatform.system}.v3
  ];
}
