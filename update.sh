#!/usr/bin/env bash
# Commit local profile changes and push them to GitHub.
# Usage: ./update.sh [commit message]
set -euo pipefail

cd "$(dirname "$0")"

branch="$(git rev-parse --abbrev-ref HEAD)"
if [[ "$branch" == "HEAD" ]]; then
  echo "detached HEAD; checkout a branch first" >&2
  exit 1
fi

msg="${1:-update profile README}"

git add -A
if git diff --cached --quiet; then
  echo "no changes to commit"
else
  git commit -m "$msg"
fi

git pull --rebase origin "$branch"
git push origin "$branch"

echo "deployed https://github.com/baozongwi/baozongwi ($branch)"
