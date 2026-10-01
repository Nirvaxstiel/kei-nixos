{ config, lib, ... }:

# To remove this module, delete its import from modules/services/default.nix.
# To change the compositor, change the command below (for example, to
# hyprland).
#
# CAUTION: a module that declares a top-level `options` key must put all config
# in the explicit `config` attribute. NixOS rejects the top-level shorthand
# (for example, `services.greetd = {...}`). This is why the file uses the
# `config = { ... }` form.
{
  options.services.greetd.user = lib.mkOption {
    type = lib.types.str;
    default = "kei";
    description = "User the graphical session starts as. Must exist (add a user module).";
  };

  config = {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${config.programs.niri.package}/bin/niri-session";
          user = config.services.greetd.user;
        };
      };
    };
  };
}
