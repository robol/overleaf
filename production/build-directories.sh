#!/bin/bash
#
# Build the directories required for the Docker container, making sure
# that they have the right permissions.

FOLDERS="web-data sharelatex-data history-v1-buckets filestore-uploads filestore-public-files filestore-template-files clsi-cache compiles"

[ -d data ] || mkdir data
cd data

for folder in ${FOLDERS}; do
  [ -d "${folder}" ] || mkdir ${folder}
  chown 1000:1000 ${folder}
done
