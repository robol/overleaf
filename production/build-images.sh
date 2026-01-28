#!/bin/bash

set -e

# 1. Change to the directory where the script is located
cd "$(dirname "$0")" || exit

# The context is the parent of services, which is "../" relative to this script
CONTEXT_DIR=".."
VERSION_TAG=$1

echo "Building with context: $(realpath $CONTEXT_DIR)"
echo "--------------------------"

# 2. Iterate through folders in ../services/
for dir in ../services/*/ cron/ nginx/; do

    # Extract the folder name (e.g., "auth-service")
    service_name=$(basename "$dir")
    image_name="robol/overleaf-$service_name"

    # Path to the Dockerfile relative to the script
    dockerfile_path="${dir}Dockerfile"

    if [ -f "$dockerfile_path" ] && [ "${service_name}" != "git-bridge" ]; then
        echo "Building $image_name..."

        # Small tweaks: images not in /services need to have the context in the actual dir
        if [ "${service_name}" = "cron" ] || [ "${service_name}" = "nginx" ]; then
          CONTEXT_DIR="${dir}"
        else
          CONTEXT_DIR=".."
        fi

        # 3. Build Command
        # -f points to the specific Dockerfile
        # $CONTEXT_DIR sets the context to the parent folder
        if [ "${service_name}" = "web" ]; then
            docker build --target app -t "$image_name:latest" -f "$dockerfile_path" "$CONTEXT_DIR"
        else
            docker build -t "$image_name:latest" -f "$dockerfile_path" "$CONTEXT_DIR"
        fi

        # 4. Optional Version Tagging
        if [ -n "$VERSION_TAG" ]; then
            docker tag "$image_name:latest" "$image_name:$VERSION_TAG"
            echo "Tagged: $image_name:$VERSION_TAG"
        fi
    else
        echo "Skipping $service_name: No Dockerfile found."
    fi

    echo "--------------------------"
done



echo "Building the texlive image ... "
docker build ../develop/texlive -t robol/overleaf-texlive-full
