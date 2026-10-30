#!/bin/bash

cd ~/JarvisProApp || exit 1

echo "🔧 [1/3] Fixing buildozer.spec..."
sed -i 's/^requirements =.*/requirements = python3==3.11.9, kivy==2.3.1, cython<3.0.0/' buildozer.spec
sed -i 's/^android.api =.*/android.api = 33/' buildozer.spec
sed -i 's/^android.ndk =.*/android.ndk = 25b/' buildozer.spec

echo "⚙️ [2/3] Writing stable workflow..."

mkdir -p .github/workflows
cat > .github/workflows/build.yml << YAML
name: Build APK
on: [push]

jobs:
  build-android:
    runs-on: ubuntu-22.04
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Java
        uses: actions/setup-java@v4
        with:
          distribution: 'temurin'
          java-version: '17'

      - name: Build with Buildozer
        uses: ArtemSBulgakov/buildozer-action@v1
        with:
          command: buildozer android debug
          buildozer_version: stable

      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: kivy-apk
          path: bin/*.apk
YAML

echo "🚀 [3/3] Pushing to GitHub..."
git add .github/workflows/build.yml buildozer.spec
git commit -m "Fix: Stable Java setup" > /dev/null 2>&1
git push origin $(git branch --show-current) -f -q

echo "✅ Done. Go to GitHub Actions tab to check."
