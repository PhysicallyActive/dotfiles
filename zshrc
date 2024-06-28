# Set and download zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -U compinit; compinit

zinit cdreplay -q

# Oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/ohmyposh.toml)"

# Set vi mode key bindings
bindkey -v

# search incrementally backwards/forwards
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Remove underscores from paths
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
ZSH_HIGHLIGHT_STYLES[precommand]="fg=green"

# History settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Style
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
zstyle ':completion:*' special-dirs true
zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls --color $realpath"
zstyle ":fzf-tab:complete:__zoxide_z:*" fzf-preview "ls --color $realpath"  # NOTE: Zoxide only supports fzf > v0.33.0

# Aliases
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi
alias nvim="~/neovim/bin/nvim"

# Halcon environment variables
export HALCONARCH="x64-linux"
export HALCONROOT="/opt/MVTec/HALCON-23.05-Progress"
export HALCONEXAMPLES="$HALCONROOT/examples"
export HALCONIMAGES="$HALCONEXAMPLES/images"
export PATH=$PATH:"$HALCONROOT/bin/$HALCONARCH"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"$HALCONROOT/lib/$HALCONARCH"

# Shell integration
# eval "$(fzf --zsh)"
export PATH=$PATH:~/.local/bin
eval "$(zoxide init --cmd cd zsh)"
