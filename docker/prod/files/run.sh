#!/bin/bash
##################################
# This script executes the service
##################################

# Configuration file location
_app_log_dir=/app/log

# Make sure relevant folders are owned by wildfly users
chown -R wildfly:wildfly $_app_log_dir

# Execute the service itself
su - wildfly -c "/opt/wildfly/bin/standalone.sh -b=0.0.0.0 -P=/app/conf/app.properties"
