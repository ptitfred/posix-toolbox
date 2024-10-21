{ packageScript, coreutils, git }:

packageScript "git-pwd" "A git script to display the path relative to the root of a git repository"
  [ coreutils git ] ./git-pwd.sh
