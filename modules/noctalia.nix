{ inputs, ... }:

{
  imports = [
    inputs.noctalia-shell.nixosModules.default
  ];

  programs.noctalia = {
    enable = true;
    # Starts the shell as a systemd user service with the session. If it does
    # not start after login, use niri spawn-at-startup instead.
    systemd.enable = true;
    # The v5 integrations read NetworkManager, Bluetooth, UPower and the power
    # profile service. Without these the panel shows stale or missing data.
    recommendedServices.enable = true;
  };
}
