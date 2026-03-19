# ---- basic environment ----
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
export EDITOR=nano
export VISUAL=nano
export PAGER=less

# ---- history ----
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt AUTO_CD
setopt CORRECT
setopt INTERACTIVE_COMMENTS

# ---- completion ----
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ---- key bindings ----
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- fzf ----
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

#  model catagoery
[ -f ~/.config/zsh/ai-models.zsh ] && source ~/.config/zsh/ai-models.zsh
[ -f ~/.config/zsh/prompt.zsh ] && source ~/.config/zsh/prompt.zsh
[ -f ~/.config/zsh/aliases.zsh ] && source ~/.config/zsh/aliases.zsh

# ---- plugins ----
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- prompt + aliases ----
[ -f ~/.config/zsh/prompt.zsh ] && source ~/.config/zsh/prompt.zsh
[ -f ~/.config/zsh/aliases.zsh ] && source ~/.config/zsh/aliases.zsh
export PATH="$HOME/bin:$PATH"
