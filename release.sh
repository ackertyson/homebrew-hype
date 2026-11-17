#!/usr/bin/env bash
# Point the formula at a published hype release, then commit and push.
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <version>" >&2
  echo "  e.g. $0 0.2.0" >&2
  exit 1
fi

VERSION="${1#v}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

"$SCRIPT_DIR/update.sh" "$VERSION"

cd "$SCRIPT_DIR"
git add Formula/hype.rb
git commit -m "hype ${VERSION}"
git push origin main

echo "Released hype ${VERSION}"
