# Enable Powerlevel10k instant prompt (must stay at top)
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Resolve DOTFILES_DIR (assuming ~/.dotfiles on distros without readlink and/or $BASH_SOURCE/$0)
READLINK=$(which greadlink || which readlink)
CURRENT_SCRIPT=$BASH_SOURCE
if [[ -n $CURRENT_SCRIPT && -x "$READLINK" ]]; then
    SCRIPT_PATH=$($READLINK -f "$CURRENT_SCRIPT")
    export DOTFILES_DIR=$(dirname "$(dirname "$SCRIPT_PATH")")
elif [ -d "$HOME/.dotfiles" ]; then
    export DOTFILES_DIR="$HOME/.dotfiles"
else
    echo "Unable to find dotfiles, exiting."
    return
fi

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(
    brew
    git
    macos
    python
    z
)

source $ZSH/oh-my-zsh.sh

# Must be at the end of oh-my-zsh setup
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Source system configuration files
source $DOTFILES_DIR/system/.function
source $DOTFILES_DIR/system/.alias
source $DOTFILES_DIR/system/.env
source $DOTFILES_DIR/system/.path

# Source API keys if they exist (gitignored)
[[ -f "$DOTFILES_DIR/secrets/.api_keys" ]] && source "$DOTFILES_DIR/secrets/.api_keys"

# OS specific commands
case $(uname) in
  Darwin)
    # Note: z plugin already loaded above, brew shellenv should be in .zprofile
    ;;
  Linux)
    # Linux-specific commands
    ;;
esac

ZSH_DISABLE_COMPFIX="true"

# === LAZY CONDA/MAMBA INITIALIZATION ===
# Saves 200-500ms on shell startup by deferring init until first use

# Detect conda location based on platform
if [[ -d "$HOME/miniforge3" ]]; then
    _CONDA_ROOT="$HOME/miniforge3"
elif [[ -d "$HOME/anaconda" ]]; then
    _CONDA_ROOT="$HOME/anaconda"
elif [[ -d "$(get-brew-prefix 2>/dev/null)/Caskroom/miniconda/base" ]]; then
    _CONDA_ROOT="$(get-brew-prefix)/Caskroom/miniconda/base"
elif [[ -d "/opt/homebrew/Caskroom/miniconda/base" ]]; then
    _CONDA_ROOT="/opt/homebrew/Caskroom/miniconda/base"
elif [[ -d "/usr/local/Caskroom/miniconda/base" ]]; then
    _CONDA_ROOT="/usr/local/Caskroom/miniconda/base"
fi

if [[ -n "$_CONDA_ROOT" ]]; then
    __conda_lazy_init() {
        # Remove the lazy wrapper functions
        unfunction conda mamba 2>/dev/null

        # Actually initialize conda
        __conda_setup="$("$_CONDA_ROOT/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)"
        if [[ $? -eq 0 ]]; then
            eval "$__conda_setup"
        else
            [[ -f "$_CONDA_ROOT/etc/profile.d/conda.sh" ]] && . "$_CONDA_ROOT/etc/profile.d/conda.sh"
        fi
        unset __conda_setup

        # Initialize mamba if available
        if [[ -x "$_CONDA_ROOT/bin/mamba" ]]; then
            export MAMBA_EXE="$_CONDA_ROOT/bin/mamba"
            export MAMBA_ROOT_PREFIX="$_CONDA_ROOT"
            eval "$("$MAMBA_EXE" shell hook --shell zsh)"
        fi
    }

    # Wrapper functions - replaced on first call
    conda() {
        __conda_lazy_init
        conda "$@"
    }

    mamba() {
        __conda_lazy_init
        mamba "$@"
    }
fi
