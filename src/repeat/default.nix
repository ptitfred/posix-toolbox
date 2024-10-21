{ packageScript, coreutils, gnused, utillinux }:

packageScript "repeat" "A script to repeat a command some times"
  [ coreutils gnused utillinux ] ./repeat.sh
