#!/bin/bash
#########################################################
# vim: ft=sh
# Convenience script for testing out the deployable image
#########################################################

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# If you want to overwrite some of these variables, now it's your chance
[ -f ${SCRIPT_DIR}/deployable.env  ] && . ${SCRIPT_DIR}/deployable.env

# Set variables that are necessary for this thingy to run
# If they haven't been exported yet
export APP_PORT=${APP_PORT:-8080}
export APP_LOG_DIR="./logs"

# Make sure that the working directory is the app root dir
cd "${SCRIPT_DIR}/../../"

# Configuration directory
export APP_CONF_DIR="./app/conf"

# Make sure relevant variables from the project are exported first
source docker/.env
source project-runner/git-info.sh
export APP_DOCKER_IMAGE="${DOCKER_IMAGE_NAME}:$(git_getRevision)"

# Run the actual thingy
project-runner/run.sh deployable
