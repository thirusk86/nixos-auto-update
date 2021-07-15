import ./module.nix ({ name, description, serviceConfig }:

{
  systemd.user.services.${name} = {
    inherit description serviceConfig;
    wantedBy = [ "default.target" ];
  };
  
  systemd.user.timers.${name} = {
    inherit description timerConfig;
    wantedBy = [ "timers.target" ];
  };  
})
