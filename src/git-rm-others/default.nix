{ packageScript, coreutils, findutils, git }:

packageScript "git-rm-others" "A git script to clean the working copy from untracked files"
  [ coreutils findutils git ] ./git-rm-others.sh
