{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord.url = "github:FlameFlag/nixcord";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hytale-launcher.url = "github:unazikx/hytale-launcher-nix";

    affinity-nix.url = "github:mrshmllow/affinity-nix";

    mistral-vibe.url = "github:mistralai/mistral-vibe";

    stream-organizer.url = "github:pocketpoke/StreamOrganizer";

    twitchdownloadercli.url = "github:pocketpoke/TwitchDownloaderCLI-Nix-Flake";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      agenix,
      ...
    }@inputs:
    {
      nixosConfigurations.tensai = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/tensai/default.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.sharedModules = [
              agenix.homeManagerModules.default
            ];
            home-manager.users.user = import ./home/home.nix;
          }
        ];
      };
    };
}
