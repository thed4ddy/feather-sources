#!/usr/bin/env bash
#
# update-source.sh — Generic updater for feather-sources
#
# Reads every JSON config in apps/, checks the upstream GitHub repo
# for new releases, and updates apps.json accordingly.
#
# Requirements: jq, gh (GitHub CLI, authenticated)
#
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
APPS_DIR="$REPO_ROOT/apps"
SOURCE_FILE="$REPO_ROOT/apps.json"
MAX_VERSIONS=5

updated=false

for config in "$APPS_DIR"/*.json; do
  [ -f "$config" ] || continue

  app_name=$(jq -r '.name' "$config")
  bundle_id=$(jq -r '.bundleIdentifier' "$config")
  repo=$(jq -r '.source.repo' "$config")
  asset_name=$(jq -r '.source.asset' "$config")

  echo "--- Checking $app_name ($repo) ---"

  # Find the current version in apps.json by bundle ID
  current_version=$(jq -r --arg bid "$bundle_id" \
    '(.apps[] | select(.bundleIdentifier == $bid) | .versions[0].version) // "none"' \
    "$SOURCE_FILE")
  echo "Current: $current_version"

  # Get latest release from GitHub
  latest_version=$(gh release view --repo "$repo" --json tagName --jq '.tagName') || {
    echo "WARNING: Could not fetch latest release for $repo, skipping"
    continue
  }
  echo "Latest:  $latest_version"

  if [ "$current_version" = "$latest_version" ]; then
    echo "Already up to date"
    continue
  fi

  echo "New version found: $latest_version"

  # Fetch release details
  release_json=$(gh release view --repo "$repo" "$latest_version" --json publishedAt,assets,body)
  date=$(echo "$release_json" | jq -r '.publishedAt')
  size=$(echo "$release_json" | jq -r --arg asset "$asset_name" \
    '[.assets[] | select(.name == $asset)][0].size')
  download_url="https://github.com/${repo}/releases/download/${latest_version}/${asset_name}"
  notes=$(echo "$release_json" | jq -r '.body' | head -20)

  if [ "$size" = "null" ] || [ -z "$size" ]; then
    echo "WARNING: Asset '$asset_name' not found in release $latest_version, skipping"
    continue
  fi

  # Build new version entry
  new_entry=$(jq -n \
    --arg ver "$latest_version" \
    --arg date "$date" \
    --argjson size "$size" \
    --arg url "$download_url" \
    --arg notes "$notes" \
    '{version: $ver, date: $date, size: $size, downloadURL: $url, localizedDescription: $notes}')

  # Check if this app already exists in apps.json
  app_exists=$(jq --arg bid "$bundle_id" \
    '[.apps[] | select(.bundleIdentifier == $bid)] | length' "$SOURCE_FILE")

  if [ "$app_exists" -gt 0 ]; then
    # Prepend new version and trim to MAX_VERSIONS
    jq --arg bid "$bundle_id" \
       --argjson entry "$new_entry" \
       --argjson max "$MAX_VERSIONS" \
       '(.apps[] | select(.bundleIdentifier == $bid) | .versions) |= ([$entry] + . | .[:$max])' \
       "$SOURCE_FILE" > "${SOURCE_FILE}.tmp" && mv "${SOURCE_FILE}.tmp" "$SOURCE_FILE"
  else
    # New app — build the full app object from config and add it
    app_obj=$(jq --argjson entry "$new_entry" \
      '. + {versions: [$entry]} | del(.source)' "$config")
    jq --argjson app "$app_obj" \
      '.apps += [$app]' "$SOURCE_FILE" > "${SOURCE_FILE}.tmp" && mv "${SOURCE_FILE}.tmp" "$SOURCE_FILE"
  fi

  echo "Updated $app_name to $latest_version"
  updated=true
done

echo "updated=$updated"
