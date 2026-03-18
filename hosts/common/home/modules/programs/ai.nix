{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    opencode
    inputs.mistral-vibe.packages.${stdenv.hostPlatform.system}.default
  ];
}
