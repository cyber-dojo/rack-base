#!/bin/bash
set -e

readonly project="${1}"

trigger_project()
{
  local vcs_type="github"
  local username="cyber-dojo"
  if [ "${CIRCLECI}" = "true" ]; then
    curl -X POST https://circleci.com/api/v1.1/project/${vcs_type}/${username}/${project}/build?circle-token=${CIRCLECI_BUILD_TOKEN}
  fi
}
