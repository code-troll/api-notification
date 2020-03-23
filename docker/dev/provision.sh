#!/bin/bash
set -e

# Install Java Development Kit and maven
apk add openjdk8 gradle -q

# Install tools needed to run the tests
apk add poppler-utils xmlsec gsettings-desktop-schemas -q

# Create a folder for the source
mkdir /app/src

# Enable debug
ln -sf /app/files/run-debug.sh /app/run.sh
