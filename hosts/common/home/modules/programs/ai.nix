{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    opencode

    inputs.claude-code.packages.${stdenv.hostPlatform.system}.claude-code
    inputs.mistral-vibe.packages.${stdenv.hostPlatform.system}.default
  ];
}
