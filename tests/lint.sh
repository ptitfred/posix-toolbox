#!/usr/bin/env bash

set -e

shellcheck --severity=error \
  git-authors \
  git-backup \
  git-bubbles \
  git-checkout-log \
  git-prd \
  git-pwd \
  git-rm-others \
  git-search \
  git-short \
  git-std-init \
  prd \
  repeat \
  short-path \
  wait-tcp
