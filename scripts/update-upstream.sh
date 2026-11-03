#!/usr/bin/env bash
set -euo pipefail
# Inspect upstream and stage a non-destructive integration; no auto-push or rollout.
git diff --quiet && git diff --cached --quiet || { echo "Dirty working tree, abort"; exit 2; }
git remote get-url upstream >/dev/null
git fetch upstream main --prune
current=$(git rev-parse HEAD)
incoming=$(git rev-parse upstream/main)
echo "Current: $current"
echo "Upstream: $incoming"
if git merge-base --is-ancestor upstream/main HEAD; then echo "Already includes upstream"; exit 0; fi
echo "Upstream changes:"
git log --oneline HEAD..upstream/main | head -30
echo "Next: review the diff and merge into a feature branch, run tests, open PR, then canary-install. No automatic production updates."
