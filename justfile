# This message
help:
  just -l

code:
  $EDITOR .

# Build the tools
tools:
  nix build

# Lint the nix files
lint:
  nix run .#lint

test:
  nix run home-manager/release-25.11 -- build --flake .#tests

# Like the CI would do
checks: lint tools test
