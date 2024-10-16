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

find "$src" -type f -name "*.nix" -exec nix-linter {} + && echo "Everything is fine!"
