#!/bin/bash
set -e

readonly api_token="${1}"
readonly project="${2}"

trigger_project()
{
  local vcs_type="github"
  local username="cyber-dojo"
  if [ "${CIRCLECI}" = "true" ]; then
    curl -X POST "https://circleci.com/api/v1.1/project/${vcs_type}/${username}/${project}/build?circle-token=${api_token}"
  fi
}
