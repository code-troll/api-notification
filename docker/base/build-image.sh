#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SCRIPT_DIR}/"

docker build . -t registry.penneo.com/penneo/openjdk:8-alpine

