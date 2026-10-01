# No filesystem from this file is mounted yet. To add one, read the device UUID
# with `ls -l /dev/disk/by-uuid/` on the installed machine, put it in place of
# UUID_HERE, then uncomment the block at the bottom.
#
# Use the fsType "ntfs-3g". The in-kernel "ntfs3" driver is faster, but it
# handles a filesystem that Windows left dirty badly. ntfs-3g is the stable
# choice for data at rest. It runs through FUSE, so pkgs.ntfs3g must be in
# environment.systemPackages. To use the kernel driver instead, change fsType to
# "ntfs3" and delete the uid, gid and umask options.
#
# When a mount returns read-only, Windows left its "Fast Startup" bit set. Boot
# Windows and run `powercfg /h off`, or run `ntfsfix -d /dev/sdX` from Linux.
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
{}
