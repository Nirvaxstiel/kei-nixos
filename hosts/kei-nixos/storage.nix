# --- DOMAIN: External Storage ---
# TRIVIA:
# 1. Why 'ntfs-3g'? Kernel 'ntfs3' driver is faster but handles
#    'dirty bits' poorly. ntfs-3g is stable for data-at-rest.
# 2. EMERGENCY: If mount fails with 'Read-only', the Windows
#    'Fast Startup' bit is set. Boot Windows -> 'powercfg /h off'
#    or run 'ntfsfix -d /dev/sdX' from Linux.
#
# FILL-UUID: run `ls -l /dev/disk/by-uuid/` on the installed box,
# paste the real id, then uncomment the block below.
# NOTE: fsType "ntfs-3g" is FUSE -> add pkgs.ntfs3g to
# environment.systemPackages, or switch fsType to in-kernel "ntfs3"
# and drop uid/gid/umask.
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
