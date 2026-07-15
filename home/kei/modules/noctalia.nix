{ inputs, ... }:

{
  imports = [
    inputs.noctalia-shell.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    # Auto-start the shell inside the Wayland session (niri-session target).
    # If it doesn't come up after login, fall back to niri spawn-at-startup.
    systemd.enable = true;
  };
}
