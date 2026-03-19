#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[*] Starting Arch lab bootstrap..."

if ! command -v sudo >/dev/null 2>&1; then
  echo "[!] sudo not found. Install base system tools first."
  exit 1
fi

echo "[*] Installing core packages..."
sudo pacman -Syu --needed \
  git openssh zsh tmux curl wget rsync tree \
  base-devel nano networkmanager \
  btop fastfetch

echo "[*] Ensuring NetworkManager is enabled..."
sudo systemctl enable NetworkManager

echo "[*] Creating standard directories..."
mkdir -p ~/lab/repos
mkdir -p ~/.config/zsh
mkdir -p ~/bin

echo "[*] Restoring user configs if present..."
cp -f "$REPO_ROOT/snapshots/config-backup/home/.zshrc" ~/.zshrc 2>/dev/null || true
cp -f "$REPO_ROOT/snapshots/config-backup/home/.bashrc" ~/.bashrc 2>/dev/null || true
cp -f "$REPO_ROOT/snapshots/config-backup/home/.tmux.conf" ~/.tmux.conf 2>/dev/null || true

if [ -d "$REPO_ROOT/snapshots/config-backup/home/.config/zsh" ]; then
  rm -rf ~/.config/zsh
  mkdir -p ~/.config
  cp -a "$REPO_ROOT/snapshots/config-backup/home/.config/zsh" ~/.config/
fi

if [ -d "$REPO_ROOT/snapshots/config-backup/home/bin" ]; then
  rm -rf ~/bin
  cp -a "$REPO_ROOT/snapshots/config-backup/home/bin" ~/
fi

echo "[*] Restoring system configs if approved..."
echo "    Review these manually before copying:"
echo "    $REPO_ROOT/snapshots/config-backup/etc/"

echo "[*] Optional package restore file available at:"
echo "    $REPO_ROOT/packages/pkglist-explicit.txt"

echo
echo "[+] Bootstrap base complete."
echo "    Next suggested steps:"
echo "    1. chsh -s /bin/zsh"
echo "    2. source ~/.zshrc"
echo "    3. restore repos into ~/lab/repos"
echo "    4. review and install additional tooling"
