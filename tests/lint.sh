#!/usr/bin/env bash

set -e

shellcheck --severity=error \
  cov \
  gerrit-cherry-pick \
  git-ampl \
  git-authors \
  git-backup \
  git-bubbles \
  git-checkout-log \
  git-deliver \
  git-prd \
  git-pwd \
  git-resurrect \
  git-rm-others \
  git-search \
  git-short \
  git-std-init \
  gps-playback \
  gps-send \
  prd \
  repeat \
  short-path \
  wait-tcp
