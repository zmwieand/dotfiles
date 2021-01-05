#!/bin/bash

JOURNAL_PATH="${HOME}/Documents/journal"
DAY=$(date "+%d")
MONTH=$(date "+%m")
YEAR=$(date "+%Y")

# Make sure the directory exists for the day/month
cd ${JOURNAL_PATH}
mkdir -p ${YEAR}/${MONTH}

ENTRY="./${YEAR}/${MONTH}/${DAY}.md"
if [[ ! -f ${ENTRY} ]]; then
  echo "### ${MONTH}/${DAY}/${YEAR}" >> ${ENTRY}
  echo "---" >> ${ENTRY}
  echo "" >> ${ENTRY}
  echo "---" >> ${ENTRY}
fi

exec vim ${ENTRY}
