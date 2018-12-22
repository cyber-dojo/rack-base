#!/bin/bash
set -e

readonly API_TOKEN="${1}"
readonly MY_DIR="$( cd "$( dirname "${0}" )" && pwd )"
. "${MY_DIR}/trigger_project.sh"
# images built FROM cyberdojo/rack-base
trigger_project "${API_TOKEN}" differ
trigger_project "${API_TOKEN}" saver
