#!/bin/bash
set -e

# Make sure that the working directory is the app root dir
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SCRIPT_DIR}/../../"

# Remove any existing artifacts
rm -rf app/deployment/*

# Private S3 maven repository from which certain dependencies are extracted
# Default: penneo-maven-repository
MVN_S3_BUCKET=${PENNEO_MVN_S3_BUCKET:-penneo-maven-repository}

# Create an environment file for maven builds inside dev container
# This environment file is used by the build script run inside the dev
# container at artifact build time, this will make this script aware of
# which S3 repository is going to rely on when extracting maven dependencies
cat << EOF > docker/dev/build.env
MVN_S3_BUCKET=${MVN_S3_BUCKET}
EOF

# Run the build process
scripts/run.sh dev run --rm app /app/scripts/tasks/build.sh
