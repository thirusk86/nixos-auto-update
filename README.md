# Service to auto update NixOS weekly through GIT

Experimental support for upadting the Nixos with the latest update from github repo.

## Installation

### Install using flakes (flake.nix)

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-auto-update.url ="github:thirusk86/nixos-auto-update/main";
  };

  outputs = inputs@{self, nixpkgs, ...}: {
    nixosConfigurations.some-host = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        # For more information of this field, check:
        # https://github.com/NixOS/nixpkgs/blob/master/nixos/lib/eval-config.nix
        modules = [
          ./configuration.nix
          {
            imports = [ inputs.nixos-auto-update.nixosModules.system ];
          }
        ];
      };
  };
}
```
### Enable service in configuration.nix
Add below lines in configuration.nix file
```
services = {
  nixos-auto-update.enable = true;
}
```

### Enable the service manually
`systemctl enable nixos-auto-update.service`

### Start the service
`systemctl start nixos-auto-update.service`

### Restart the service
The service can be restarted with `systemctl restart nixos-auto-update` or by rebooting the machine.
