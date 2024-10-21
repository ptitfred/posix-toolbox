{ packageScript, coreutils }:

packageScript "prd" "A script to print the working directory relative to your HOME directory"
  [ coreutils ] ./prd.sh
