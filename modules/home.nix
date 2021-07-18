import ./module.nix ({ name, description, serviceConfig, timerConfig }:

  {
    systemd.services.${name} = {
      Unit = {
        Description = description;
      };

      Service = serviceConfig;

      Install = {
        WantedBy = [ "default.target" ];
        after = [ "network.target" ];
      };
    };

    systemd.timers.${name} = {
      Unit = {
        Description = description;
      };

      Timer = timerConfig;

      Install = {
        WantedBy = [ "timers.target" ];
      };
    };

  })
