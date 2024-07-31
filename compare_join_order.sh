#!/usr/bin/env bash

folder1="results"
folder2="results_with_accurate_his"

if [[ ! -d "$folder1" || ! -d "$folder2" ]]; then
  echo "One of dir does not exist"
  exit 1
fi

files=$(ls "$folder1")

for file in $files; do
  file1="$folder1/$file"
  file2="$folder2/$file"

  if [[ -f "$file1" && -f "$file2" ]]; then
    if ! cmp -s "$file1" "$file2"; then
      echo "$file1 and $file2 have different content"
      diff "$file1" "$file2"
      echo "========================="
    fi
  else
    echo "$file1 or $file2 does not exist"
  fi
done