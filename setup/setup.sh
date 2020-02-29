#!/usr/bin/env bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

SETUP_DIRS=(
  "applications"
  "cli"
  "files"
  "python"
  "postgres"
  "karabiner_elements"
)

for dir in "${SETUP_DIRS[@]}"; do
  SCRIPT="${ROOT_DIR}/${dir}/setup.sh"
  LOG="${ROOT_DIR}/${dir}/log.out"

  if [ -f "$SCRIPT" ]; then
      echo "Running ${SCRIPT}" >> $LOG
      echo $(date) > $LOG
      echo "" >> $LOG
      sh $SCRIPT >> $LOG
      echo "" >> $LOG
      echo $(date) > $LOG
  else
    echo "$SCRIPT does not exist."
  fi
done
