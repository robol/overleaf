#!/usr/bin/env bash

set -eu

. /etc/environment

echo "-------------------------"
echo "Expiring deleted projects"
echo "-------------------------"
date

if [[ "${ENABLE_CRON_RESOURCE_DELETION:-null}" != "true" ]]; then
  echo "Skipping project expiration due to ENABLE_CRON_RESOURCE_DELETION not set to true"
  exit 0
fi

WEB_URL="http://${WEB_HOST}:3000"

curl -X POST -q -u "${WEB_API_USER}:${WEB_API_PASS}" \
  "${WEB_URL}/internal/expire-deleted-projects-after-duration"

echo "Done."
