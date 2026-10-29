#!/bin/bash
sed -i 's/^requirements = .*/requirements = python3==3.11.9, hostpython3==3.11.9, kivy==2.3.1, cython==0.29.34/' buildozer.spec
sed -i 's/^p4a.branch = .*/p4a.branch = develop/' buildozer.spec
echo ".buildozer/" >> .gitignore
git rm -r --cached .buildozer > /dev/null 2>&1
git add buildozer.spec .gitignore
git commit -m "Fix: Force Python 3.11.9 and p4a develop branch"
git push -u origin main -f -q

echo "🚀 Pushed! Waiting for GitHub..."
LATEST_COMMIT=$(git rev-parse HEAD)
RUN_ID=""

while [ -z "$RUN_ID" ] || [ "$RUN_ID" == "null" ]; do
    sleep 3
    RUN_ID=$(gh run list --limit 5 --json databaseId,headSha --jq ".[] | select(.headSha==\"$LATEST_COMMIT\") | .databaseId" | head -n 1)
done

while true; do
    RUN_DATA=$(gh run view $RUN_ID --json status,conclusion,createdAt --jq '.')
    STATUS=$(echo "$RUN_DATA" | jq -r '.status')
    CONCLUSION=$(echo "$RUN_DATA" | jq -r '.conclusion')
    START=$(echo "$RUN_DATA" | jq -r '.createdAt')
    
    START_TS=$(date -d "$START" +%s 2>/dev/null || date -j -f "%Y-%m-%dT%H:%M:%SZ" "$START" +%s)
    NOW_TS=$(date -u +%s)
    ELAPSED=$((NOW_TS - START_TS))
    MINS=$((ELAPSED / 60))
    SECS=$((ELAPSED % 60))

    echo "Status: $STATUS | Time: ${MINS}m ${SECS}s | Conclusion: ${CONCLUSION:-pending}"

    if [ "$STATUS" == "completed" ]; then
        if [ "$CONCLUSION" == "success" ]; then
            echo "✅ SUCCESS! Downloading..."
            rm -rf build_dl && mkdir build_dl
            gh run download $RUN_ID -n kivy-apk -D build_dl 2>/dev/null
            cd build_dl && unzip *.zip > /dev/null 2>&1
            mkdir -p ~/storage/downloads/AppBuilds
            APK=$(find . -name "*.apk" | head -n 1)
            [ -n "$APK" ] && cp "$APK" ~/storage/downloads/AppBuilds/ 2>/dev/null && echo "🎉 Saved to Downloads/AppBuilds" && termux-open ~/storage/downloads/AppBuilds/"$(basename "$APK")"
            cd .. && rm -rf build_dl
            break
        else
            echo "❌ FAILED! Errors:"
            gh run view $RUN_ID --log-failed | grep -i -E "error|exception|failed" | tail -n 10
            break
        fi
    fi
    sleep 15
done
