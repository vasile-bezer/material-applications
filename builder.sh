#!/bin/bash

set -e

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <github_repo_url> <docker_repo_name>"
  echo "Example: $0 https://github.com/user/myapp.git mydockeruser/myimage"
  exit 1
fi

GITHUB_PREF="https://github.com/"
GITHUB_REPO="$1"
DOCKER_REPO="$2"
CLONE_DIR="temp-repo"

read -p "Docker Hub Username: " DOCKER_USERNAME
read -s -p "Docker Hub Password (or access token): " DOCKER_PASSWORD
echo ""

echo "Cloning $GITHUB_REPO..."
rm -rf "$CLONE_DIR"
git clone "$GITHUB_PREF$GITHUB_REPO" "$CLONE_DIR"

cd "$CLONE_DIR"
echo "Building Docker image $DOCKER_REPO..."
docker build -t "$DOCKER_REPO" .

echo "Logging in to Docker Hub..."
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

echo "Pushing $DOCKER_REPO to Docker Hub..."
docker push "$DOCKER_REPO"

cd ..
rm -rf "$CLONE_DIR"

echo "Image succesfully pushed to Docker Hub: $DOCKER_REPO"

