{ packageScript, coreutils, findutils, git, gnused }:

packageScript "git-authors" "A git script to list committers other a commit range"
  [ coreutils findutils git gnused ] ./git-authors.sh
