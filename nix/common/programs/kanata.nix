{config, lib, pkgs, ...}:
{
  boot.kernelModules = [ "uinput" ];
  hardware.uinput.enable = true;
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  users.groups.uinput = { };
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = ''
          process-unmapped-keys yes
        '';
        config = ''
            (defsrc
              a s d f g h j k l ;
            )

            (deflayer base
              (tap-hold 160 160 a lmet)
              (tap-hold 160 160 s lalt)
              (tap-hold 160 160 d lctl)
              (tap-hold 160 160 f lsft)
              (tap-hold 160 160 g ret)

              (tap-hold 160 160 h ret)
              (tap-hold 160 160 j rsft)
              (tap-hold 160 160 k rctl)
              (tap-hold 160 160 l ralt)
              (tap-hold 160 160 ; rmet)
            )
        '';
      };
    };
  };
}
