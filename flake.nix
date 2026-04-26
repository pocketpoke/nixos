{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vast-cli = {
      url = "github:dialohq/vast-cli.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hytale-launcher.url = "github:pocketpoke/hytale-launcher-nix";
    affinity-nix.url = "github:mrshmllow/affinity-nix";
    mistral-vibe.url = "github:mistralai/mistral-vibe";
    stream-organizer.url = "github:pocketpoke/StreamOrganizer/dev";
    twitchdownloadercli.url = "github:pocketpoke/TwitchDownloaderCLI-Nix-Flake";
    claude-code.url = "github:sadjow/claude-code-nix";
    codex-cli-nix.url = "github:sadjow/codex-cli-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      sops-nix,
      ...
    }@inputs:
    {
      nixosConfigurations.tensai = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/tensai/system

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.sharedModules = [
              sops-nix.homeManagerModules.sops
            ];
            home-manager.users.user = import ./hosts/tensai/home;
          }
        ];
      };

    };
}
