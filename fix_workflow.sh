#!/bin/bash

cd ~/JarvisProApp || exit 1

echo "🔧 Fixing workflow..."

mkdir -p .github/workflows
cat > .github/workflows/build.yml << 'YAML'
name: Build APK
on: [push, workflow_dispatch]

jobs:
  build-android:
    runs-on: ubuntu-22.04
    steps:
      - uses: actions/checkout@v4
      
      - name: Build APK with Docker
        run: |
          docker run --rm -i -v "${{ github.workspace }}":/app -w /app \
            --entrypoint /bin/bash \
            -e BUILDOZER_WARN_ON_ROOT=0 \
            -e APP_ANDROID_ACCEPT_SDK_LICENSE=1 \
            kivy/buildozer:latest -c "
              sudo rm -f /etc/apt/sources.list.d/openjdk-r-ppa*.list
              sudo apt-get update || true
              sudo apt-get install -y openjdk-17-jdk
              buildozer android debug
            "

      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: kivy-apk
          path: bin/*.apk
YAML

echo "🚀 Pushing to GitHub..."
git add .github/workflows/build.yml
git commit -m "Fix: Correct entrypoint syntax" > /dev/null 2>&1
git push origin $(git branch --show-current) -f -q

echo "✅ Done. Go to GitHub Actions tab."
