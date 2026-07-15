# --- DOMAIN: User Shell (Home-Manager) ---
# TRIVIA:
# 1. programs.bash owns ~/.bashrc / ~/.profile / ~/.bash_profile as symlinks.
# 2. LANDMINE: editing those files directly = wiped on next rebuild.
#    Put every change here (initExtra / shellAliases), never the symlink.
# 3. EMERGENCY: 'read-only' on a dotfile = you are editing a managed symlink.
#    Stop, modify the Nix source, rebuild.
{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    # Example aliases only — commented out; prefer full `ls -la` by habit.
    # shellAliases = {
    #   ll = "ls -l";
    #   la = "ls -A";
    #   ".." = "cd ..";
    # };

    initExtra = ''
      export EDITOR=${pkgs.vim}/bin/vim
    '';
  };

  # User identity (per DDD: capability at system, identity at user).
  # FILL: set your real name/email; git commit will prompt without these.
  programs.git = {
    enable = true;
    userName = "REPLACE_WITH_GIT_NAME";
    userEmail = "replace@example.com";
  };
}
