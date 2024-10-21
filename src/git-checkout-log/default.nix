{ packageScript, coreutils, git, gnused, less }:

packageScript "git-checkout-log" "A git script to browser reflog and follow checkouts"
  [ coreutils git gnused less ] ./git-checkout-log.sh
