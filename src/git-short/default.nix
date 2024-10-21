{ packageScript, git }:

packageScript "git-short" "A git script to display short SHA1 of a given commit"
  [ git ] ./git-short.sh
