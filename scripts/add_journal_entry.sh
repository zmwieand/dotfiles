#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Must provide journal path i.e. Personal"
  exit 1
fi

JOURNAL_PATH="${HOME}/dev/journal/$1"
DAY=$(date "+%d")
MONTH=$(date "+%m")
YEAR=$(date "+%Y")

# Make sure the directory exists for the day/month
cd ${JOURNAL_PATH}
mkdir -p ${YEAR}/${MONTH}

ENTRY="./${YEAR}/${MONTH}/${DAY}.md"
if [[ ! -f ${ENTRY} ]]; then
  echo "# ${MONTH}/${DAY}/${YEAR}" >> ${ENTRY}
  echo "---" >> ${ENTRY}
  echo "" >> ${ENTRY}
  echo "### " >> ${ENTRY}
fi

exec vim -c "NERDTree journal" ${ENTRY}
