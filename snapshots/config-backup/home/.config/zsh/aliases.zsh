# =========================
# SAFE FILE OPERATIONS
# =========================
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

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

# =========================
# GIT SHORTCUTS
# =========================
alias gs='git status'
alias ga='git add -A'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate -20'

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
