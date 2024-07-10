{
  description = "jänkhäs flakey flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";

    home-manager-unstable.url = "github:nix-community/home-manager/master";
    home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs";

    home-manager-stable.url = "github:nix-community/home-manager/relase-24.05";
    home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";

  }

  outputs = inputs@{self,...}:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        system = inputs.lib.nixosSystem {
           inherit system;
           modules = [./configuration.nix];
        };
      };
    };
}
