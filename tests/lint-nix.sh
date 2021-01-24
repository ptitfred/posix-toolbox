#!/usr/bin/env bash

set -e

find -name '*.nix' | xargs nix-linter
