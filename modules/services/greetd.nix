{ config, lib, ... }:

# Flip/remove: drop this module's import from modules/services/default.nix.
# Swap compositor: change the command below (e.g. to hyprland).
#
# LANDMINE: once a module declares a top-level `options` key, ALL config must
# live under the explicit `config` attr — top-level config shorthand (e.g.
# `services.greetd = {...}`) is rejected. Hence the `config = { ... }` wrap.
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
