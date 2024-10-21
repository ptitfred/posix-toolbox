{ packageScript, coreutils, git, gnused }:

packageScript "git-bubbles" "A git script to handle pull requests"
  [ coreutils git gnused ] ./git-bubbles.sh
