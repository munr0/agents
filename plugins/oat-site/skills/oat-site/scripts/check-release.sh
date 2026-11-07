#!/bin/sh
# Check the latest Oat release against the Oat minor version this skill covers.
#
# The plugin version tracks Oat: major.minor = the Oat release the reference is
# written for, patch = this skill's own revisions. Upstream patch releases are
# fixes only, so they don't make the skill outdated, but sites should still pin
# the latest patch.
#
# Usage: sh check-release.sh
# Exit:  0 = current, 1 = outdated (newer Oat minor/major), 2 = couldn't check

PKG=@knadh/oat
ROOT=$(cd "$(dirname "$0")/../../.." && pwd)
COVERS=$(sed -n 's/.*"version": *"\([0-9]*\.[0-9]*\)\..*/\1/p' "$ROOT/.claude-plugin/plugin.json")

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

echo "covers: $COVERS.x (references/oat-$COVERS.md)"
if [ -z "$latest" ]; then
  echo "latest: unknown (no network access to npm or GitHub)"
  echo "status: unchecked - tell the user the reference may be out of date"
  echo "pin:    $PKG@$COVERS.0"
  exit 2
fi
echo "latest: $latest"
echo "pin:    $PKG@$latest"

if [ "${latest%.*}" = "$COVERS" ]; then
  echo "status: current"
  exit 0
fi

echo "status: outdated - Oat $latest is newer than the $COVERS.x this skill covers"
echo "  changelog: https://github.com/knadh/oat/compare/v$COVERS.0...v$latest"
echo "  docs:      https://oat.ink (always shows the latest release)"
echo "  see 'Updating this reference' in references/oat-$COVERS.md"
exit 1
