{ packageScript, findutils, git, gnugrep }:

packageScript "git-search" "A git script to search the diff other a commit range"
  [ findutils git gnugrep ] ./git-search.sh
