#!/usr/bin/env bash

set -eu

. /etc/environment

echo "-------------------------"
echo "Deactivating old projects"
echo "-------------------------"
date

if [[ "${ENABLE_CRON_RESOURCE_DELETION:-null}" != "true" ]]; then
  echo "Skipping old project deactivation due to ENABLE_CRON_RESOURCE_DELETION not set to true"
  exit 0
fi

WEB_URL="http://${WEB_HOST}:3000"

USER=${WEB_API_USER}
PASS=${WEB_API_PASSWORD}

curl -q -X POST                                                \
  -u "${USER}:${PASS}"                                         \
  -H "Content-Type: application/json"                          \
  -d '{"numberOfProjectsToArchive":"720","ageOfProjects":"7"}' \
  "${WEB_URL}/internal/deactivateOldProjects"

echo "Done."
