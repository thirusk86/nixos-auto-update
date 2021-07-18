{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  description = "Auto update NixOS weekly";
  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, ... }: {
    nixosModules = {
      configuration = { config, pkgs, ... }:
        let
          overlay-unstable = final: prev: {
            unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
          };
        in
          { nixpkgs.overlays = [ overlay-unstable ]; };
      system = import ./modules;
      homeManager = import ./modules/home.nix;

    };
  };
}
