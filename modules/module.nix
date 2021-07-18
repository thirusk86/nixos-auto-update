moduleConfig:
{ lib, pkgs, config, ... }:

with lib;

{
  options.services.nixos-auto-update = with types;{
    enable = mkEnableOption "Auto update NixOS weekly";
    gitPackage = mkOption {
      type = package;
      default = pkgs.git;
    };
    #nixFlakesPackage = mkOption {
      #type = package;
      #default = pkgs.nixFlakes;
    #};
    nixRebuildPackage = mkOption {
      type = package;
      default = pkgs.nixos-rebuild;
    };
  };

  config =
    let
      cfg = config.services.nixos-auto-update;
      gitPath = "${cfg.gitPackage}/bin/git";
      #nixFlakesPath = "${cfg.nixFlakesPackage}/bin/nix";
      nixRebuildPath = "${cfg.nixRebuildPackage}/bin/nixos-rebuild";
      mkStartScript = name: pkgs.writeShellScript "${name}.sh" ''
        set -euo pipefail
        PATH=${makeBinPath (with pkgs; [ git ])}
        cd /etc/nixos/
        ${gitPath} pull origin master
        /run/current-system/sw/bin/nixos-rebuild switch --flake '/etc/nixos/#nixtst' --impure
        #${nixRebuildPath} switch --flake '/etc/nixos/#nixtst' --impure
      '';
    in
      mkIf cfg.enable (
        moduleConfig rec {
          name = "nixos-auto-update";
          description = "Auto update NixOS weekly";
          serviceConfig = {
            ExecStart = "${mkStartScript name}";
          };
	  timerConfig = {
	    OnBootSec = "15m"; # first run 5min after boot up
	    OnUnitActiveSec = "1w"; # run weekly
	  };
        }
      );
}
