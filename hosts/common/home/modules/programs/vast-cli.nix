{
  pkgs,
  config,
  inputs,
  ...
}:

{
  imports = [
    inputs.vast-cli.homeManagerModules.default
  ];

  programs.vastai = {
    enable = true;

    sshConfig = {
      enable = true;

      apiKeyFile = "${config.home.homeDirectory}/.config/vastai/vast_api_key";
    };
  };
}
