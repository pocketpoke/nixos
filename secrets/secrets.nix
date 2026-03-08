let
  me = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMsJ/s743FSXHpaDphhSiP9CFNAGAf7R0Io9Xdgzc3g1 user@Rem";
in
{
  "chatterino2-settings.age".publicKeys = [
    me
  ];
}
