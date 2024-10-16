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

function check {
  local filename="$1"
  echo "$filename"
  aspell list < "$filename"
}

check "$src"/README.md
