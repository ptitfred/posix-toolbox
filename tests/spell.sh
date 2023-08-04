function check {
  local filename="$1"
  echo "$filename"
  aspell list < "$filename"
}

check README.md
