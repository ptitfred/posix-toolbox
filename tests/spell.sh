#!/usr/bin/env bash

function check {
  local filename="$1"
  echo "$filename"
  aspell list < "$filename"
}

check README.md
