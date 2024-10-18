{ excludedPaths
, lib, pinned-nix-linter, writeShellApplication }:

let toFindExcludedPath = path: "! -path \"$src/${path}\"";
    excludedPathsStr = lib.strings.concatMapStringsSep " " toFindExcludedPath excludedPaths;
 in writeShellApplication {
      name = "nix-linter";
      runtimeInputs = [ pinned-nix-linter ];
      text = ''
        set -e

        src="."
        if [ $# -ge 1 ]
        then
          src="$1"
        fi

        if [ -z "$src" ]
        then
          src="."
        fi

        find "$src" -type f -name "*.nix" ${excludedPathsStr} -exec nix-linter {} + && echo "Everything is fine!"
      '';
    }
