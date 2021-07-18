{
  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  description = "Auto update NixOS weekly";
  outputs = { self, nixpkgs }: {
    nixosModules = {
      system = import ./modules;
      homeManager = import ./modules/home.nix;
    };
  };
}
