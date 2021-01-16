# Update PATH.
export CARGO_DIR="$HOME/.cargo/bin"
export PATH="$CARGO_DIR:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Bira theme is cool.
ZSH_THEME="bira"

# Automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# Run `oh-my-zsh`.
source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions (do I need this?)
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# TODO add aliases.
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Setup user-specific configuration.
source $HOME/.shell_user_rc

# Setup kubectl aliases
# Aliases can be downloaded from here: https://github.com/ahmetb/kubectl-aliases
[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases
