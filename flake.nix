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
      # get a neewr version of awesomewm v4.3 is 4 years old...
      awesome-git-overlay = final: prev : {
        awesome = (prev.lib.removeAttrs 
            (prev.awesome.overrideAttrs (old: {
              version = "20240606-git";
              src = prev.fetchFromGitHub {
                owner = "awesomeWM";
                repo = "awesome";
                rev = "ad0290bc1aac3ec2391aa14784146a53ebf9d1f0";
                sha256 = "uaskBbnX8NgxrprI4UbPfb5cRqdRsJZv0YXXshfsxFU=";
              };
            outputs = ["out"];
            patches = [];
          })) 
          ["patches"]);
        };

      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config= {
          allowUnfree = true;
          allowUnfreePredicate = (_:true);
        };
        overlays = [
          inputs.rust-overlay.overlays.default
          awesome-git-overlay
        ];
      };
      lib = nixpkgs.lib;
    in
  {
    nixosConfigurations = {
      carbon = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./configuration.nix];
        specialArgs = {
          inherit pkgs;
          inherit inputs;
        };
      };
    };
  };
}
