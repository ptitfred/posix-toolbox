# FIXME: make buildInputs dependent on the target system (darwin vs linux)

{ packageScript, coreutils, gawk, gnugrep, gnused, lsof, psmisc }:

packageScript "wait-tcp" "A script to wait for some server sockets to be opened on a TCP"
  [ coreutils gawk gnugrep gnused lsof psmisc ] ./wait-tcp.sh
