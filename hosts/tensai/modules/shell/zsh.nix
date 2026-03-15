{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zsh
    zsh-powerlevel10k
    zsh-autosuggestions
    zsh-syntax-highlighting
    meslo-lgs-nf
  ];

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    histSize = 10000;
    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';

    ohMyZsh.enable = true;
    ohMyZsh.plugins = [
      "git"
      "docker"
    ];

    shellAliases = {
      rebuild = "pushd ~/.config/nixos; sudo nixos-rebuild switch --flake .; popd";
      update = "pushd ~/.config/nixos; nix flake update; popd";
    };
  };

  users.users.user = {
    shell = pkgs.zsh;
  };
}
