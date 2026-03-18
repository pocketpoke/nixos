{ ... }:

{
  imports = [
    ./bootloader.nix
    ./cifs.nix
    ./luks.nix
    ./splash.nix
    ./storage.nix
  ];
}
