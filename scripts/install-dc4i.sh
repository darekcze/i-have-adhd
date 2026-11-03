#!/usr/bin/env bash
set -euo pipefail
# Install a fixed local checkout, no remote code execution or implicit updates.
src="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
target="${1:-$HOME/.agents/skills/dc4i-adhd-execution}"
if [[ ! -f "$src/skills/dc4i-adhd-execution/SKILL.md" ]]; then echo "Missing skill"; exit 2; fi
mkdir -p "$(dirname "$target")"
if [[ -e "$target" || -L "$target" ]]; then
  backup="${target}.backup.$(date -u +%Y%m%dT%H%M%SZ)"
  mv "$target" "$backup"
  echo "Backup: $backup"
fi
mkdir -p "$target"
cp "$src/skills/dc4i-adhd-execution/SKILL.md" "$target/SKILL.md"
echo "Installed: $target"
cmp "$src/skills/dc4i-adhd-execution/SKILL.md" "$target/SKILL.md"
echo "Verified checksum: $(shasum -a 256 "$target/SKILL.md" | awk '{print $1}')"
base_target="$(dirname "$target")/i-have-adhd"
if [[ ! -e "$base_target" ]]; then
  mkdir -p "$base_target"
  cp "$src/skills/i-have-adhd/SKILL.md" "$base_target/SKILL.md"
  echo "Installed upstream baseline: $base_target"
else
  echo "Existing upstream baseline preserved: $base_target"
fi
