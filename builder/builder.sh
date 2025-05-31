#!/bin/sh

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

# Check environment variables
if [ -z "$DOCKER_USER" ] || [ -z "$DOCKER_PWD" ]; then
  echo "Error: DOCKER_USER and DOCKER_PWD environment variables must be set."
  exit 1
fi

echo "Cloning $GITHUB_REPO..."
rm -rf "$CLONE_DIR"
git clone "$GITHUB_PREF$GITHUB_REPO" "$CLONE_DIR"

cd "$CLONE_DIR"

echo "Building Docker image $DOCKER_REPO..."
docker build -t "$DOCKER_REPO" .

echo "Logging in to Docker Hub..."
echo "$DOCKER_PWD" | docker login -u "$DOCKER_USER" --password-stdin

echo "Pushing $DOCKER_REPO to Docker Hub..."
docker push "$DOCKER_REPO"

cd ..
rm -rf "$CLONE_DIR"

echo "✅ Image successfully pushed to Docker Hub: $DOCKER_REPO"
