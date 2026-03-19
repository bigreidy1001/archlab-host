#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[*] Running full host backup/export..."
"$REPO_ROOT/backup/export-host-state.sh"
"$REPO_ROOT/backup/backup-configs.sh"

echo "[*] Git status after backup:"
git -C "$REPO_ROOT" status --short || true

echo
echo "[+] Backup run complete."
echo "    Review changes with:"
echo "    git -C \"$REPO_ROOT\" status"
