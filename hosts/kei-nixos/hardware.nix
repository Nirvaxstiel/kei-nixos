# The real hardware description lives in hardware.local.nix (gitignored,
# machine-specific). Regenerate it on the target from hosts/kei-nixos/ with:
#   sudo nixos-generate-config --show-hardware-config > hardware.local.nix
import ./hardware.local.nix
