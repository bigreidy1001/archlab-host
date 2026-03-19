#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PKG_FILE="$REPO_ROOT/packages/pkglist-explicit.txt"

if [ ! -f "$PKG_FILE" ]; then
  echo "[!] Package list not found: $PKG_FILE"
  exit 1
fi

echo "[*] Installing explicit packages from:"
echo "    $PKG_FILE"

sudo pacman -Syu --needed $(grep -vE '^\s*$' "$PKG_FILE")

echo "[+] Explicit package restore complete."
echo "[!] AUR packages, if any, must be restored separately."
