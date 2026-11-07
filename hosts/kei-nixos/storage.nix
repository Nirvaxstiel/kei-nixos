# The actual mounts live in storage.local.nix, which is machine-specific and
# gitignored. The import below is REQUIRED — the eval fails without the file,
# so a clone never silently mounts another machine's disks. On a new machine,
# create an empty module (`printf '{}\n' > storage.local.nix`) and add mounts
# there.
import ./storage.local.nix

# Mount template. Read the filesystem's UUID with `ls -l /dev/disk/by-uuid/`,
# put it in place of UUID_HERE, then copy the block into storage.local.nix.
# A by-uuid device survives a port swap or a renumbered /dev node; a
# /dev/sdX* or /dev/nvmeXnYpZ name does not.
#
# fileSystems."/mnt/data" = {
#   device = "/dev/disk/by-uuid/UUID_HERE";
#   fsType = "ntfs-3g";
#   options = [
#     "uid=1000"
#     "gid=100"
#     "umask=0022"
#     "nofail"
#     "x-systemd.automount"
#   ];
# };
#
# fsType "auto" does not guarantee a particular NTFS driver. Set "ntfs3"
# for the kernel driver or "ntfs-3g" for FUSE. Both support uid, gid and
# umask. On NixOS 26.05, boot.supportedFilesystems = [ "ntfs" ] supplies
# the ntfs-3g mount helper.
#
# If an NTFS volume refuses to mount read-write, the volume may be flagged
# dirty — commonly by Windows "Fast Startup" on shutdown. Boot Windows and
# run `powercfg /h off`. `ntfsfix` only clears the dirty flag and fixes very
# basic problems; it is NOT a chkdsk replacement, and a filesystem with real
# corruption needs Windows' `chkdsk /f` to repair before it will mount
# read-write again.
