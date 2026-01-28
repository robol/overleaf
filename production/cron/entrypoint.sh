#!/bin/bash

# 1. Export all environment variables to /etc/environment
# This allows cron jobs to access variables passed via 'docker run -e'
declare -p | grep -Ev 'BASHOPTS|BASH_VERSINFO|EUID|PPID|SHELLOPTS|UID' > /etc/environment

echo "Cron service for Overleaf starting."
echo ""
echo "Configuration:"
echo " - ENABLE_CRON_RESOURCE_DELETION=${ENABLE_CRON_RESOURCE_DELETION}"
echo " - WEB_HOST=${WEB_HOST}"
echo " - PROJECT_HISTORY_HOST=${PROJECT_HISTORY_HOST}"
echo ""

# 2. Start cron in the foreground with log level 15 (all logs)
# Using 'exec' ensures signals (SIGTERM) are handled correctly
exec cron -f -L 15
