{ ... }:

{
  imports = [
    ./bootloader.nix
    ./cifs.nix
    ./luks.nix
    ./storage.nix
  ];
}
