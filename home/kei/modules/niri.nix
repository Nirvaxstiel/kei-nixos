{ config, lib, pkgs, ... }:

let
  # niri fills each section of the config from its defaults.
  # The `binds` section is an exception. The niri manual writes:
  # "they do not get filled with defaults, so make sure you do not erase
  # this section". A config file must therefore contain the binds.
  # This seed starts from the niri default config. That is the same file that
  # the niri binary contains.
  niriDefaultConfig =
    builtins.readFile "${pkgs.niri.src}/resources/default-config.kdl";

  # Display layout for this machine.
  # The refresh rate must match `niri msg outputs` exactly, with three
  # decimal digits. If the rate does not match, niri selects a mode itself.
  # Positions are in logical pixels. The cursor moves between two outputs
  # only when they touch. The space between DP-2 and DP-1 is deliberate.
  displayLayout = ''
    output "DP-1" {
      mode "3440x1440@164.900"
      scale 1
      transform "normal"
      position x=3440 y=-180
    }

    output "DP-2" {
      mode "1920x1080@144.001"
      scale 1
      transform "normal"
      position x=0 y=0
    }
  '';

  seedConfig = pkgs.writeText "niri-seed-config.kdl" ''
    ${niriDefaultConfig}
    ${displayLayout}
  '';
in
{
  # niri writes this file itself at the first start.
  # A home-manager symlink is read-only, and it collides with the niri copy.
  # For these reasons, this activation copies the seed only when the file is
  # absent. An existing file stays as it is. As a result, live edits survive a
  # rebuild. To load the seed again, delete the file and run the activation.
  home.activation.niriSeeding = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -e "${config.home.homeDirectory}/.config/niri/config.kdl" ]; then
      run ${pkgs.coreutils}/bin/install -Dm644 ${seedConfig} "${config.home.homeDirectory}/.config/niri/config.kdl"
    fi
  '';
}
