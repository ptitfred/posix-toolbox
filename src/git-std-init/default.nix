{ packageScript, coreutils, git }:

packageScript "git-std-init" "A git script to setup a repository with an initial empty commit and a base and master branches"
  [ coreutils git ] ./git-std-init.sh
