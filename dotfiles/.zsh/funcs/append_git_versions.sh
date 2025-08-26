#!/bin/zsh
#
# This was run at the root of the `billing-events` repo.
# The goal was to append all versions of all avsc files to one output file.
# From there I used vim to sort and dedupe the result before I manually cleaned
# it up to ensure it only contained the jsonb object keys we see in Ripley events.

function append_git_versions {
  local file_name=$1
  local output_file=$2

  if [[ -z "$file_name" || -z "$output_file" ]]; then
    echo "Usage: append_git_versions <file_name> <output_file>"
    return 1
  fi

  if ! git ls-files --error-unmatch "$file_name" > /dev/null 2>&1; then
    echo "Error: $file_name is not tracked by git."
    return 1
  fi

  local file_commits
  file_commits=$(git log --pretty=format:%H -- "$file_name")

  for commit in $file_commits; do
    git checkout $commit
    cat $file_name >> $output_file
  done

  git checkout master

  echo "All versions of $file_name have been appended to $output_file."
}

output_file="output.txt"
input_directory="src/main/avro"

for file in "$input_directory"/*.avsc; do
  append_git_versions "$file" "$output_file"
done
