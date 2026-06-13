{ excludedPaths
, coreutils, findutils, lib, nil, writeShellApplication }:

let toFindExcludedPath = path: "! -path \"$src/${path}\"";
    excludedPathsStr = lib.strings.concatMapStringsSep " " toFindExcludedPath excludedPaths;
 in writeShellApplication {
      name = "nix-linter";
      runtimeInputs = [ coreutils findutils nil];
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

        output="$(mktemp nix-lint-XXXXXX.log)"

        function cleanup() {
          rm "$output"
        }

        trap cleanup EXIT

        find "$src" -type f -name "*.nix" ${excludedPathsStr} -exec nil diagnostics {} + | tee -a "$output"

        if [[ $(wc -l "$output") == "0 $output" ]]; then
          echo "Everything is fine!"
        else
          exit 1
        fi
      '';
    }
