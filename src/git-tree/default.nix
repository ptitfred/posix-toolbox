{ packageScript, coreutils, git, tree }:

packageScript "git-tree" "A git script to tree files handled by git"
  [ coreutils git tree ] ./git-tree.sh
