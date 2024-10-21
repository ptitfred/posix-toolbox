{ packageScript, git, prd }:

packageScript "git-prd" "A git script to display the path of the root of a git repository relative to your HOME directory"
  [ git prd ] ./git-prd.sh
