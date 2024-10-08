# This message
help:
  just -l

# Build the tools
tools:
  nix build

# Lint the nix files
lint:
  nix run .#lint

# Like the CI would do
checks: lint tools
