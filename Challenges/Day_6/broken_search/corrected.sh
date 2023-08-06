#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: ./recursive_search.sh <directory> <target_file>"
  exit 1
fi

search_directory="$1"
target_file="$2"

if [ ! -d "$search_directory" ]; then
  echo "Error: Directory '$search_directory' not found."
  exit 1
fi

function search_recursive {
  local dir="$1"
  local target="$2"

  for file in "$dir"/*; do
    if [ -f "$file" ] && [ "$(basename "$file")" == "$target" ]; then
      echo "File found: $file"
      exit 0
    elif [ -d "$file" ]; then
      search_recursive "$file" "$target"
    fi
  done
}

search_recursive "$search_directory" "$target_file"
echo "File not found: $target_file"
exit 1

