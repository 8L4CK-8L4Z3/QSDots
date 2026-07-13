# QSDotfiles — zsh configuration
# Source shared variables
source_file() {
  [[ -f "$1" ]] && source "$1"
}
source_file "$HOME/.config/variables"

# Oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="xiong-chiamiov-plus"

plugins=(
  git
  docker
  dotenv
  github
  lol
  nvm
  npm
  ssh
  yarn
  rust
  archlinux
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Source secrets (DO NOT COMMIT — gitignored)
source_file "$HOME/.config/zsh/secrets"

# Aliases
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias cl='clear'
alias z='zeditor'
alias cr='cargo run'
alias ci='cargo init'
alias cb='cargo build'
alias cch='cargo check'
alias ccl='cargo clean'
alias cn='cargo new'
alias cbr='cargo build --release'
alias py='python'
alias lzd='lazydocker'
alias tauri='yarn tauri'
alias gemini='agy'

# FZF key bindings
source <(fzf --zsh 2>/dev/null)

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Completion
zstyle ':completion:*' menu select

# Fastfetch (theme-aware)
fastfetch -c "$HOME/.config/fastfetch/config.jsonc"
