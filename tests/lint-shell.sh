#!/usr/bin/env bash

set -e

shellcheck $(git ls-files src/)
