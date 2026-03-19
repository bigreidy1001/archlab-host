#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DOCS="$REPO_ROOT/docs"
OUT_PACKAGES="$REPO_ROOT/packages"
OUT_MANIFESTS="$REPO_ROOT/manifests"
OUT_SNAPSHOTS="$REPO_ROOT/snapshots"

mkdir -p "$OUT_DOCS" "$OUT_PACKAGES" "$OUT_MANIFESTS" "$OUT_SNAPSHOTS"

echo "[*] Exporting package lists..."
pacman -Qqe > "$OUT_PACKAGES/pkglist-explicit.txt"
pacman -Qqem > "$OUT_PACKAGES/pkglist-aur.txt" || true

echo "[*] Exporting service state..."
systemctl list-unit-files --state=enabled > "$OUT_DOCS/enabled-systemd-units.txt" || true
systemctl --user list-unit-files --state=enabled > "$OUT_DOCS/enabled-user-systemd-units.txt" || true

echo "[*] Exporting mount and disk info..."
lsblk -f > "$OUT_DOCS/lsblk-f.txt"
findmnt > "$OUT_DOCS/findmnt.txt"
df -h > "$OUT_DOCS/df-h.txt"
cat /etc/fstab > "$OUT_MANIFESTS/fstab.current"

echo "[*] Exporting network and host info..."
hostnamectl > "$OUT_DOCS/hostnamectl.txt" || true
ip addr show > "$OUT_DOCS/ip-addr.txt" || true
ip route show > "$OUT_DOCS/ip-route.txt" || true

echo "[*] Exporting installed packages metadata..."
pacman -Q > "$OUT_PACKAGES/pkglist-full.txt"

echo "[*] Exporting boot and kernel info..."
uname -a > "$OUT_DOCS/uname-a.txt"
bootctl status > "$OUT_DOCS/bootctl-status.txt" 2>/dev/null || true

echo "[*] Exporting important versions..."
{
  echo "git: $(git --version 2>/dev/null || true)"
  echo "ssh: $(ssh -V 2>&1 || true)"
  echo "zsh: $(zsh --version 2>/dev/null || true)"
  echo "tmux: $(tmux -V 2>/dev/null || true)"
  echo "docker: $(docker --version 2>/dev/null || true)"
  echo "ollama: $(ollama --version 2>/dev/null || true)"
} > "$OUT_DOCS/tool-versions.txt"

STAMP="$(date +%Y-%m-%d_%H-%M-%S)"
{
  echo "snapshot_time=$STAMP"
  echo "hostname=$(hostname)"
  echo "user=${USER:-unknown}"
  echo "kernel=$(uname -r)"
} > "$OUT_SNAPSHOTS/last-export.env"

echo "[+] Host state export complete."
