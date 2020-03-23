#!/bin/bash
set -e

WILDFLY_VER=9.0.2.Final
JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk

# Common Util
apk add wget unzip openssl -q

# Add User
adduser -D -H --g "" wildfly

# Install Wildfly
# @todo: verify checksums
echo "Downloading and installing JBoss"
wget -q --show-progress http://download.jboss.org/wildfly/$WILDFLY_VER/wildfly-$WILDFLY_VER.zip -O /tmp/wildfly.zip
unzip -q /tmp/wildfly.zip -d /opt/
rm -rf /tmp/wildfly.zip
ln -s /opt/wildfly-$WILDFLY_VER /opt/wildfly
chown -R wildfly:wildfly /opt/wildfly-$WILDFLY_VER

# Remove the welcome content
rm -rf /opt/wildfly/welcome-content

# Add the app and deployment folder
mkdir -p /app/deployment
chown -R wildfly:wildfly /app/deployment

# Symlink the run script in place and make sure that it is executable
ln -sf /app/files/run.sh /app/run.sh
chmod a+x /app/files/run.sh

# Symlink Wildfly configuration and modules
ln -sf /app/files/opt/wildfly/standalone/configuration/standalone.xml /opt/wildfly/standalone/configuration/standalone.xml
ln -sf /app/files/opt/wildfly/modules/com /opt/wildfly/modules/com

# Set up the log directory
mkdir -p /app/log
ln -sf /app/log /opt/wildfly/standalone/log

# Install unlimited encryption strength JAR files (for BankID NO)
ln -sf /app/files/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/local_policy.jar ${JAVA_HOME}/jre/lib/security/local_policy.jar
ln -sf /app/files/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/US_export_policy.jar ${JAVA_HOME}/jre/lib/security/US_export_policy.jar