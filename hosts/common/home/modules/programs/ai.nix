{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    inputs.mistral-vibe.packages.${stdenv.hostPlatform.system}.default
  ];
}
