#!/usr/bin/env bash
# Package MFC skills into dist/*.skill for direct client delivery
# (hand clients the .skill file — no marketplace / plugin install).
#
# Usage:
#   package-skills.sh                 # refresh every skill that already
#                                     # has a dist/<name>.skill (the
#                                     # "published set"), keeping them current
#   package-skills.sh NAME [NAME...]  # package these specific skills
#
# A skill only gets a .skill once you package it by name the first time;
# after that it joins the published set and stays auto-refreshed. This
# keeps the set bounded (we do NOT package all ~80 skills).
#
# The skill-creator packager location can be overridden:
#   SKILL_CREATOR_DIR=/path/to/skill-creator package-skills.sh
#
# Exit non-zero if any skill fails validation (e.g. description >1024
# chars) — callers (and the pre-commit hook) should treat that as fatal
# so a broken skill is never shipped.

set -euo pipefail

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$PLUGIN_DIR/skills"
DIST_DIR="$PLUGIN_DIR/dist"

DEFAULT_SC="$HOME/.claude/plugins/marketplaces/claude-plugins-official/plugins/skill-creator/skills/skill-creator"
SKILL_CREATOR_DIR="${SKILL_CREATOR_DIR:-$DEFAULT_SC}"

if [[ ! -f "$SKILL_CREATOR_DIR/scripts/package_skill.py" ]]; then
  echo "ERROR: skill-creator packager not found at:" >&2
  echo "  $SKILL_CREATOR_DIR/scripts/package_skill.py" >&2
  echo "Set SKILL_CREATOR_DIR to the skill-creator skill directory." >&2
  exit 2
fi

mkdir -p "$DIST_DIR"

# Resolve the target skill list.
targets=()
if [[ $# -gt 0 ]]; then
  targets=("$@")
else
  # Refresh the published set: every dist/<name>.skill that has a source.
  shopt -s nullglob
  for f in "$DIST_DIR"/*.skill; do
    name="$(basename "$f" .skill)"
    [[ -d "$SKILLS_DIR/$name" ]] && targets+=("$name")
  done
  shopt -u nullglob
fi

if [[ ${#targets[@]} -eq 0 ]]; then
  echo "Nothing to package (no named skills, no published set in dist/)."
  exit 0
fi

failed=()
for name in "${targets[@]}"; do
  src="$SKILLS_DIR/$name"
  if [[ ! -d "$src" ]]; then
    echo "SKIP  $name — no source dir at $src" >&2
    failed+=("$name")
    continue
  fi
  echo "Packaging $name ..."
  if ( cd "$SKILL_CREATOR_DIR" && python3 -m scripts.package_skill "$src" ) >/tmp/pkg-"$name".log 2>&1; then
    mv -f "$SKILL_CREATOR_DIR/$name.skill" "$DIST_DIR/$name.skill"
    echo "  OK -> dist/$name.skill"
  else
    echo "  FAILED — see /tmp/pkg-$name.log:" >&2
    grep -iE "validation failed|too long|error" /tmp/pkg-"$name".log >&2 || tail -3 /tmp/pkg-"$name".log >&2
    failed+=("$name")
  fi
done

if [[ ${#failed[@]} -gt 0 ]]; then
  echo "FAILED: ${failed[*]}" >&2
  exit 1
fi
echo "All packaged: ${targets[*]}"
