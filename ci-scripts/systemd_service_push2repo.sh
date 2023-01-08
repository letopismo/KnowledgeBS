#!/usr/bin/env bash
set -eu

if [[ -z  ${SSH_AUTH_SOCK:=} ]] ; then
  eval `ssh-agent -s`
fi

ssh-add $HOME/.ssh/* || :

SCRIPT_DIR=$(dirname $(dirname $(realpath "$0")))
echo "SCRIPT_DIR is $SCRIPT_DIR"

cd "$SCRIPT_DIR"
# git update-index --refresh
git add *
git add -u
if $(git diff-index --quiet HEAD --); then
   echo "$(date +%S:%M:%H_%d.%m.%Y) - no changes found in Knowlegde Database"
else
  echo "$(date +%S:%M:%H_%d.%m.%Y) - committing to Knowlegde Database"
  git commit -am "commit on $(date +%S:%M:%H_%d.%m.%Y)"
  git push -f -v
fi

