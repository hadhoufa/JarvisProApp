#!/bin/bash

cd ~/JarvisProApp || exit 1

echo "🔧 [1/2] Creating simple, working workflow..."

mkdir -p .github/workflows
cat > .github/workflows/build.yml << 'YAML'
name: Build APK
on: [push, workflow_dispatch]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Build with Buildozer
        uses: ArtemSBulgakov/buildozer-action@v1
        id: buildozer
        with:
          command: buildozer android debug
          buildozer_version: stable

      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: kivy-apk
          path: ${{ steps.buildozer.outputs.filename }}
YAML

echo "🚀 [2/2] Pushing to GitHub..."
git add .github/workflows/build.yml
git commit -m "Final: Simple official action" > /dev/null 2>&1
git push origin $(git branch --show-current) -f -q

echo "✅ Done! Wait 2 minutes, then check GitHub Actions."
