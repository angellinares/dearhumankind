#!/usr/bin/env bash
# generate-manifest.sh
# Run this locally to preview the site without GitLab CI.
# Writes articles/manifest.json so index.html can find your articles.

set -e

ARTICLES_DIR="$(dirname "$0")/articles"

if [ ! -d "$ARTICLES_DIR" ]; then
  echo "Error: articles/ directory not found."
  exit 1
fi

cd "$ARTICLES_DIR"

echo "[" > manifest.json
first=true
for f in $(ls *.md 2>/dev/null | sort); do
  if [ "$first" = true ]; then
    printf '  "%s"' "$f" >> manifest.json
    first=false
  else
    printf ',\n  "%s"' "$f" >> manifest.json
  fi
done
echo "" >> manifest.json
echo "]" >> manifest.json

echo "manifest.json written to articles/:"
cat manifest.json
