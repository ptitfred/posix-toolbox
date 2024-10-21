{ packageScript, coreutils, gnused }:

packageScript "short-path" "A script to abbreviate every directory unless the last part of a path"
  [ coreutils gnused ] ./short-path.sh
