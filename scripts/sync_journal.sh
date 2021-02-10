#~!/bin/bash

JOURNAL_PATH=$HOME/dev/journal

cd ${JOURNAL_PATH}
git pull origin main
git add .

# If there is a change to this repo commit and push it to the remote
if [[ ! -z $(git diff HEAD) ]]; then
  git commit -m "[$(date +"%m/%d/%Y %H:%M:%S")] sync"
  git push origin main
fi
