#!/usr/bin/env bash
# Regenerate Formula/hype.rb from hype.rb.template for a published release.
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <version>" >&2
  echo "  e.g. $0 0.2.0" >&2
  exit 1
fi

VERSION="${1#v}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE="$SCRIPT_DIR/hype.rb.template"
OUTPUT="$SCRIPT_DIR/Formula/hype.rb"
TARGETS=(aarch64-apple-darwin x86_64-apple-darwin aarch64-unknown-linux-musl x86_64-unknown-linux-musl)

CHECKSUMS_URL="https://github.com/ackertyson/hype/releases/download/v${VERSION}/checksums.txt"

echo "Fetching checksums from $CHECKSUMS_URL ..."
CHECKSUMS=$(curl -sfL "$CHECKSUMS_URL") || {
  echo "Error: failed to fetch checksums for v${VERSION} (has the Release workflow finished?)" >&2
  exit 1
}

SED_ARGS=(-e "s/@@VERSION@@/${VERSION}/g")
for target in "${TARGETS[@]}"; do
  sha=$(echo "$CHECKSUMS" | awk -v f="hype-${VERSION}-${target}.tar.gz" '$2 == f { print $1 }')
  if ! [[ "$sha" =~ ^[0-9a-f]{64}$ ]]; then
    echo "Error: no checksum for $target in checksums.txt. Contents:" >&2
    echo "$CHECKSUMS" >&2
    exit 1
  fi
  echo "$target: $sha"
  placeholder="SHA256_$(echo "$target" | tr 'a-z-' 'A-Z_')"
  SED_ARGS+=(-e "s/@@${placeholder}@@/${sha}/g")
done

sed "${SED_ARGS[@]}" "$TEMPLATE" > "$OUTPUT"

if grep -q '@@' "$OUTPUT"; then
  echo "Error: unfilled placeholders in $OUTPUT" >&2
  exit 1
fi

echo "Generated $OUTPUT"
