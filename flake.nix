{
  description = "jänkhä's flakey flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";

    home-manager-unstable.url = "github:nix-community/home-manager/master";
    home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs";

    home-manager-stable.url = "github:nix-community/home-manager/release-24.05";
    home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";
    
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = inputs@{self, nixpkgs, nixpkgs-stable, ...}:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config= {
          allowUnfree = true;
          allowUnfreePredicate = (_:true);
        };
        overlays = [
          inputs.rust-overlay.overlays.default
        ];
      };
      lib = nixpkgs.lib;
    in
      {
      nixosConfigurations = {
        carbon = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
          ];
          specialArgs = {
            inherit pkgs;
            inherit inputs;
          };
        };
      };
    };
}
