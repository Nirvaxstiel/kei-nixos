# TRIVIA:
# 1. programs.bash owns ~/.bashrc / ~/.profile / ~/.bash_profile as symlinks.
# 2. CAUTION: an edit to those files does not survive the next rebuild.
#    Put each change in this file (initExtra / shellAliases), not in the
#    symlink.
# 3. EMERGENCY: a 'read-only' error on a dotfile means that you edit a managed
#    symlink. Stop. Change the Nix source. Then rebuild.
{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    # Example aliases. This block is commented out. The habit is to use the
    # full `ls -la`.
    # shellAliases = {
    #   ll = "ls -l";
    #   la = "ls -A";
    #   ".." = "cd ..";
    # };

    initExtra = ''
      export EDITOR=${pkgs.vim}/bin/vim
    '';
  };
}
