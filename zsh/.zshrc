# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"
alias lzd='lazydocker'

plugins=(git zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# --- script for tmux-sessionizer ----
PATH="$PATH":"$HOME/.local/scripts/"

bindkey -s ^f "tmux-sessionizer\n"

# ---- Eza (better ls) -----
alias ls='eza --icons=always --no-filesize --no-user --modified --header'

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# ---- FZF -----
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

alias cd="z"

alias vim="nvim"
alias gli="golangci-lint"

# -- use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# export PS1="%{$fg_bold[magenta]%}%n@%{$reset_color%} %{$fg_bold[blue]%}%~%{$reset_color%} %B»%b "

# go exports
export GOROOT=/usr/local/go
export GOPATH=$HOME/go

export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

source ~/fzf-git.sh/fzf-git.sh
source ~/.config/.zsh/prompt.sh

