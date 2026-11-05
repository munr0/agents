#!/bin/sh
# Compare the Oat version this skill's reference is pinned to with the latest
# release on npm (which is published from the GitHub tags).
#
# Usage: sh check-release.sh
# Exit:  0 = up to date, 1 = newer release available, 2 = couldn't check

PINNED=1.1.0
PKG=@knadh/oat

latest=""
if command -v npm >/dev/null 2>&1; then
  latest=$(npm view "$PKG" version 2>/dev/null)
fi
if [ -z "$latest" ] && command -v curl >/dev/null 2>&1; then
  latest=$(curl -fsSL "https://registry.npmjs.org/$PKG/latest" 2>/dev/null |
    sed -n 's/.*"version":"\([^"]*\)".*/\1/p' | head -n 1)
fi
if [ -z "$latest" ] && command -v curl >/dev/null 2>&1; then
  latest=$(curl -fsSL "https://api.github.com/repos/knadh/oat/releases/latest" 2>/dev/null |
    sed -n 's/.*"tag_name": *"v\{0,1\}\([^"]*\)".*/\1/p' | head -n 1)
fi

echo "pinned: $PINNED"
if [ -z "$latest" ]; then
  echo "latest: unknown (no network access to npm or GitHub)"
  echo "status: unchecked - use the pinned reference, and tell the user it may be out of date"
  exit 2
fi
echo "latest: $latest"

if [ "$latest" = "$PINNED" ]; then
  echo "status: current - the bundled reference matches the latest release"
  exit 0
fi

echo "status: newer release available"
echo "  changelog: https://github.com/knadh/oat/compare/v$PINNED...v$latest"
echo "  docs:      https://oat.ink (always shows the latest release)"
echo "  see 'Updating this reference' in references/oat-$PINNED.md"
exit 1
