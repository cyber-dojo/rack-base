#!/bin/bash
set -ev

readonly REPO_URL="${1}"                   # eg https://github.com/cyber-dojo/differ.git
readonly REPO_NAME=$(basename "${1}" .git) # eg differ
readonly SHA="${2}"

cd /tmp
git clone "${REPO_URL}"
cd "${REPO_NAME}"
echo "${SHA}" > rack-base.trigger
git add .
git config --global user.email "cyber-dojo-machine-user@cyber-dojo.org"
git config --global user.name "Machine User"
git commit -m "automated build trigger from cyberdojo/rack-base ${SHA}"
git push origin master
