#!/usr/bin/env bash

set -e

shellcheck \
  src/git-authors \
  src/git-bubbles \
  src/git-checkout-log \
  src/git-prd \
  src/git-pwd \
  src/git-rm-others \
  src/git-search \
  src/git-short \
  src/git-std-init \
  src/prd \
  src/repeat \
  src/short-path \
  src/wait-tcp
