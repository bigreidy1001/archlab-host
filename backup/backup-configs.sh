#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CFG_ROOT="$REPO_ROOT/snapshots/config-backup"

mkdir -p "$CFG_ROOT/home" "$CFG_ROOT/etc"

echo "[*] Backing up user shell configs..."
cp -f ~/.zshrc "$CFG_ROOT/home/.zshrc" 2>/dev/null || true
cp -f ~/.bashrc "$CFG_ROOT/home/.bashrc" 2>/dev/null || true
cp -f ~/.tmux.conf "$CFG_ROOT/home/.tmux.conf" 2>/dev/null || true

echo "[*] Backing up ~/.config/zsh ..."
mkdir -p "$CFG_ROOT/home/.config"
rm -rf "$CFG_ROOT/home/.config/zsh"
cp -a ~/.config/zsh "$CFG_ROOT/home/.config/" 2>/dev/null || true

echo "[*] Backing up ~/bin ..."
rm -rf "$CFG_ROOT/home/bin"
cp -a ~/bin "$CFG_ROOT/home/" 2>/dev/null || true

echo "[*] Backing up sanitized system configs..."
cp -f /etc/fstab "$CFG_ROOT/etc/fstab" 2>/dev/null || true
cp -f /etc/hosts "$CFG_ROOT/etc/hosts" 2>/dev/null || true
cp -f /etc/pacman.conf "$CFG_ROOT/etc/pacman.conf" 2>/dev/null || true
cp -f /etc/makepkg.conf "$CFG_ROOT/etc/makepkg.conf" 2>/dev/null || true

echo "[*] Backing up systemd units (if present)..."
mkdir -p "$CFG_ROOT/etc/systemd-system"
cp -a /etc/systemd/system/. "$CFG_ROOT/etc/systemd-system/" 2>/dev/null || true

echo "[+] Config backup complete."
echo "    Output: $CFG_ROOT"

