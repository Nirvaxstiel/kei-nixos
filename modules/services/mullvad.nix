{ pkgs, ... }:

{
  # The module default is pkgs.mullvad, the CLI-only build: daemon runs, but no
  # window exists. mullvad-vpn is the same daemon plus the Electron GUI and its
  # desktop entry.
  services.mullvad-vpn.enable = true;
  # Re-login to see the GUI after adding this line
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
}
