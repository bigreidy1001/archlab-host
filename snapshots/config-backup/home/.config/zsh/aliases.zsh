# =========================
# SAFE FILE OPERATIONS
# =========================

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias save='cp -i'

# =========================
# NAVIGATION
# =========================

alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

# =========================
# SYSTEM
# =========================

alias c='clear'
alias reload='source ~/.zshrc'
alias zshconfig='nano ~/.zshrc'
alias aliasedit='nano ~/.config/zsh/aliases.zsh'
alias promptedit='nano ~/.config/zsh/prompt.zsh'


####################################
# ---- NEW CONSOLE (SMART SPAWN) ----
####################################

# ---- TERMINAL CONTROL ----

# Clear any old aliases to avoid zsh conflicts
unalias newshell 2>/dev/null
unalias killshell 2>/dev/null
unalias newkitty 2>/dev/null
unalias killkitty 2>/dev/null

# ---- NEWSHELL (REPLACE CURRENT TERMINAL) ----
newshell() {
  echo "🪟 Spawning fresh shell..."

  if command -v kgx >/dev/null 2>&1; then
    kgx & disown
  elif command -v kitty >/dev/null 2>&1; then
    kitty & disown
  elif command -v gnome-terminal >/dev/null 2>&1; then
    gnome-terminal & disown
  else
    echo "❌ No supported terminal found."
    return 1
  fi

  sleep 0.3
  echo "💀 Closing current shell..."
  exit
}

# ---- KILLSHELL (CURRENT ONLY) ----
killshell() {
  echo "💀 Terminating current shell..."
  kill -9 $$
}

# ---- KITTY TERMINAL ----
newkitty() {
  echo "🐱 Opening kitty..."
  kitty & disown
}

killkitty() {
  echo "💀 Killing all kitty terminals..."
  pkill -f kitty 2>/dev/null || echo "No kitty processes found."
}



# ==========================
# ---- TERMINAL CONTROL ----
# ==========================

alias newterm='gnome-terminal & disown'

newtermwkill() {
  echo "💀 Killing existing terminal windows..."
  pkill -f gnome-terminal

  sleep 1

  echo "🌱 Spawning fresh terminal..."
  gnome-terminal & disown
}


# =========================
# GIT SHORTCUTS
# =========================
alias gs='git status'
alias ga='git add -A'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate -20'

# ========================
# ---- LAB BACKUP ----
# ========================

backall() {
  local REPO=~/lab/repos/archlab-host

  echo "🚀 Running full lab backup..."
  cd "$REPO" || return 1

  ./backup/run-all-backups.sh

  echo
  echo "📊 Git status:"
  git status --short

  echo
  echo "💡 Tip: run 'git add . && git commit -m \"backup\" && git push'"
}


# ---- LAB BACKUP (AUTO) ----
backallA() {
  local REPO=~/lab/repos/archlab-host
  local MSG="backup: $(date +'%Y-%m-%d %H:%M:%S')"

  echo "🚀 Starting full lab backup..."
  cd "$REPO" || return 1

  ./backup/run-all-backups.sh

  echo
  echo "🔍 Checking for changes..."

  if [[ -z $(git status --porcelain) ]]; then
    echo "✅ No changes to commit."
    return 0
  fi

  echo "📦 Changes detected. Committing..."
  git add .

  git commit -m "$MSG" || {
    echo "⚠️ Commit failed or nothing to commit."
    return 1
  }

  echo "⬆️ Pushing to GitHub..."
  git push

  echo "✅ Backup complete and synced."
}



# =========================
# AI SYSTEM (FUNCTIONS ONLY — NO ALIASES)
# =========================

runai() {
  echo "${AI_SAFE_ICON} Safe AI online (${AI_SAFE_NAME})"
  ollama run "${AI_SAFE_MODEL}"
}

runnsai() {
  echo "${AI_NSAI_ICON} NotSafe AI unleashed (${AI_NSAI_NAME})"
  ollama run "${AI_NSAI_MODEL}"
}

run() {
  case "$1" in
    ai)
      echo "${AI_SAFE_ICON} Safe AI online (${AI_SAFE_NAME})"
      ollama run "${AI_SAFE_MODEL}"
      ;;
    nsai)
      echo "${AI_NSAI_ICON} NotSafe AI unleashed (${AI_NSAI_NAME})"
      ollama run "${AI_NSAI_MODEL}"
      ;;
    *)
      echo "Usage: run ai | run nsai"
      ;;
  esac
}

aiwhich() {
  echo "Safe AI    : ${AI_SAFE_NAME} -> ${AI_SAFE_MODEL}"
  echo "NotSafe AI : ${AI_NSAI_NAME} -> ${AI_NSAI_MODEL}"
}

ailist() {
  ollama list
}

aiset() {
  local mode="$1"
  local model="$2"
  local name="${3:-$2}"

  if [[ -z "$mode" || -z "$model" ]]; then
    echo "Usage: aiset safe|nsai <model> [display-name]"
    return 1
  fi

  case "$mode" in
    safe)
      sed -i "s|^export AI_SAFE_NAME=.*|export AI_SAFE_NAME=\"${name}\"|" ~/.config/zsh/ai-models.zsh
      sed -i "s|^export AI_SAFE_MODEL=.*|export AI_SAFE_MODEL=\"${model}\"|" ~/.config/zsh/ai-models.zsh
      ;;
    nsai)
      sed -i "s|^export AI_NSAI_NAME=.*|export AI_NSAI_NAME=\"${name}\"|" ~/.config/zsh/ai-models.zsh
      sed -i "s|^export AI_NSAI_MODEL=.*|export AI_NSAI_MODEL=\"${model}\"|" ~/.config/zsh/ai-models.zsh
      ;;
    *)
      echo "Usage: aiset safe|nsai <model> [display-name]"
      return 1
      ;;
  esac

  source ~/.config/zsh/ai-models.zsh
  echo "Updated ${mode} model."
  aiwhich
}
