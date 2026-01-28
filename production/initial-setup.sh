#!/bin/bash
#
# Build the directories required for the Docker container, making sure
# that they have the right permissions.

function randomToken {
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1
}

FOLDERS="web-data sharelatex-data history-v1-buckets filestore-uploads filestore-public-files filestore-template-files clsi-cache clsi-cache/01 clsi-cache/02 compiles compiles/01 compiles/02"

echo -n "Creating data directories ... "

[ -d data ] || mkdir data
cd data

for folder in ${FOLDERS}; do
  [ -d "${folder}" ] || mkdir -p ${folder}
  chown 1000:1000 ${folder}
done

cd ..

echo "done"

echo -n "Generating secret tokens ... "
echo "OT_JWT_AUTH_KEY=$(randomToken)"  >  secrets.env
echo "SESSION_SECRET=$(randomToken)"   >> secrets.env
echo "WEB_API_USER=$(randomToken)"     >> secrets.env
echo "WEB_API_PASSWORD=$(randomToken)" >> secrets.env
v1=$(randomToken)
echo "STAGING_PASSWORD=${v1}"          >> secrets.env
echo "V1_HISTORY_PASSWORD=${v1}"       >> secrets.env
echo "done"

if [ -x oauth2.env ]; then
  echo "If you need OAuth2 support, edit oauth2.env.template -> oauth2.env"
fi
