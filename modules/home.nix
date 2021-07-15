import ./module.nix ({ name, description, serviceConfig }:

{
  systemd.user.services.${name} = {
    Unit = {
      Description = description;
    };

    Service = serviceConfig;

    Install = {
      WantedBy = [ "default.target" ];
	  after = [ "network.target" ];
    };
  };
  
  systemd.user.timers.${name} = {
    Unit = {
      Description = description;
    };

    Timer = timerConfig;

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };  
 
})
