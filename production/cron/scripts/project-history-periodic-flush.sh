#!/usr/bin/env bash

set -eu

. /etc/environment

echo "--------------------------"
echo "Flush project-history queue"
echo "--------------------------"
date

PROJECT_HISTORY_URL="http://${PROJECT_HISTORY_HOST}:3054"

curl -q -X POST "${PROJECT_HISTORY_URL}/flush/old?timeout=3600000&limit=5000&background=1"
