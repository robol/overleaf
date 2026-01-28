#!/usr/bin/env bash

set -eu

. /etc/environment


echo "-----------------------------------"
echo "Retry project-history errors (soft)"
echo "-----------------------------------"

PROJECT_HISTORY_URL="http://${PROJECT_HISTORY_HOST}:3054"

curl -q -X POST "${PROJECT_HISTORY_URL}/retry/failures?failureType=soft&timeout=3600000&limit=10000"
