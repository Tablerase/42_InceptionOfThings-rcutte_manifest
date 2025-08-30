#!/bin/bash

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <new_version>"
  exit 1
fi

NEW_VERSION="$1"
DEPLOY_FILE="./manifests/deployment.yaml"

# 1️⃣ Swap version in deployment.yaml
echo "🔄 Updating $DEPLOY_FILE to version $NEW_VERSION..."
sed -i "s|\(wil42/playground:\)[^[:space:]]*|\1$NEW_VERSION|g" "$DEPLOY_FILE"

# 2️⃣ Git add, commit, push
git add "$DEPLOY_FILE"
git commit -m "chore: update playground image to $NEW_VERSION"
git push

echo "✅ Updated version to $NEW_VERSION and pushed to Git."

