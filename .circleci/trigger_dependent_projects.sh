#!/bin/bash
set -e

echo "CIRCLECI==:${CIRCLECI}:"

readonly MY_DIR="$( cd "$( dirname "${0}" )" && pwd )"
. ${MY_DIR}/trigger_project.sh
# These projects create an image FROM cyberdojo/rack-base
trigger_project differ
trigger_project saver
