#!/usr/bin/env bash

#==============================================================================
# The MIT License
#
# Copyright (c) 2012-, Frédéric Menou
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#==============================================================================

function help {
  echo "Usage: wait-for (-v) port [timeout]"
  echo "       port is a TCP port number, or the service name (for instance http, ssh)"
  echo "       timeout is expressed in seconds"
  echo "             optional (defaulted to 30)"
  echo "             if <= 0, no timeout"
  exit 1
}

if [ $# -eq 0 ]; then
  help
fi

VERBOSE=0
if [ "$1" = "-v" ]; then
  VERBOSE=1
  shift 1
fi

PORT=$1

# timeout in seconds
TIMEOUT=30
if [ $# -ge 2 ]; then
  TIMEOUT=$2
fi

SLEEP=1s

function now {
  date +%s
}

startTime=$(now)

function checkTimeout {
  if [ "$TIMEOUT" -gt 0 ]; then
    current=$(now)
    elapsed=$(( current - startTime ))
    if [ $elapsed -ge "$TIMEOUT" ]; then
      echo "Timeout" >&2
      exit 2
    fi
  fi
}

function getPortForOS() {
  case "$OSTYPE" in
    darwin* )  lsof -n -i4TCP:"${PORT}" | grep LISTEN ;;
    *       )  fuser "$PORT"/tcp ;;
  esac
}

function getOwnerForOS() {
  case "$OSTYPE" in
    darwin* )  getPortForOS | awk '{print $3}' ;;
    *       )  getPortForOS | sed -e 's/^.* \([0-9]*\)$/\1/' ;;
  esac
}

function checkPort {
  getPortForOS 2>/dev/null | wc -c
}

if [ "$(checkPort)" = 0 ] && [ $VERBOSE -eq 1 ]; then
  echo "Waiting for TCP port $PORT"
fi

while [ "$(checkPort)" = 0 ]
do
  checkTimeout
  sleep $SLEEP
done

getOwnerForOS
