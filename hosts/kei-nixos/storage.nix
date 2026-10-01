# TRIVIA:
# 1. Use 'ntfs-3g' here. The kernel 'ntfs3' driver is faster, but it handles
#    'dirty bits' badly. ntfs-3g is stable for data at rest.
# 2. EMERGENCY: a mount that fails with 'Read-only' means that the Windows
#    'Fast Startup' bit is set. Boot Windows and run 'powercfg /h off'. Or run
#    'ntfsfix -d /dev/sdX' from Linux.
#
# FILL-UUID: run `ls -l /dev/disk/by-uuid/` on the installed box. Paste the real
# id. Then uncomment the block below.
# NOTE: fsType "ntfs-3g" is FUSE. Add pkgs.ntfs3g to
# environment.systemPackages, or change fsType to the in-kernel "ntfs3" and
# remove uid/gid/umask.
# fileSystems."/mnt/my-data" = {
#   device = "/dev/disk/by-uuid/YOUR-LONG-UUID-HERE";
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
