export PATH=$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:/usr/bin:/usr/local/bin:/sbin:$HOME/go/bin:$PATH

ZSH_DISABLE_COMPFIX=true

export XDG_CONFIG_HOME="$HOME/.config/"

# Turn on Go Modules
export GO111MODULE=on

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export MYVIMRC="$HOME/.config/nvim"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode auto
zstyle ':completion:*' menu select

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(zsh-256color zsh-completions zsh-autosuggestions zsh-syntax-highlighting
  colored-man-pages docker git 
)

#source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='nvim'

alias zshconf="chezmoi edit ~/.zshrc"
alias starshipconf="chezmoi edit ~/.config/starship.toml" # Open starship config
alias kittyconf="chezmoi edit ~/.config/kitty"
alias hyprconf="chezmoi edit ~/.config/hypr" 
alias wayconf="chezmoi edit ~/.config/waybar"

alias cdn="cd /etc/dotfiles"
alias fu="nix flake update /etc/dotfiles/nix"
alias nixup="sudo nixos-rebuild switch --flake /etc/dotfiles/nix#desktop"

alias l="eza --long --header --git --no-permissions --no-user --all --grid --icons"
alias ll="eza --long --no-user --git --all --icons"

alias refresh="source ~/.zshrc" # Refresh terminal without having to close it.

alias findFile="find / -type f -iname" # Easier command to search system for a file name
alias lg="lazygit" # Open lazygit terminal gui
alias tree="tree -C -a -I '.git|.github|.yarn|.DS_Store|node_modules'"

eval "$(starship init zsh)"

