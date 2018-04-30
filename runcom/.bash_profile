# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Resolve DOTFILES_DIR (assuming ~/.dotfiles on distros without readlink and/or $BASH_SOURCE/$0)
READLINK=$(which greadlink || which readlink)
CURRENT_SCRIPT=$BASH_SOURCE

if [[ -n $CURRENT_SCRIPT && -x "$READLINK" ]]; then
  SCRIPT_PATH=$($READLINK -f "$CURRENT_SCRIPT")
  DOTFILES_DIR=$(dirname "$(dirname "$SCRIPT_PATH")")
elif [ -d "$HOME/.dotfiles" ]; then
  DOTFILES_DIR="$HOME/.dotfiles"
else
  echo "Unable to find dotfiles, exiting."
  return
fi

# Read cache
DOTFILES_CACHE="$DOTFILES_DIR/.cache.sh"
[ -f "$DOTFILES_CACHE" ] && . "$DOTFILES_CACHE"

# Finally we can source the dotfiles (order matters)
for DOTFILE in "$DOTFILES_DIR"/system/.{function,path,env,alias,completion,prompt}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done

# Use autoenv
# https://github.com/kennethreitz/autoenv
source $(brew --prefix autoenv)/activate.sh

# Hook for extra/custom stuff
DOTFILES_EXTRA_DIR="$HOME/.extra"

if [ -d "$DOTFILES_EXTRA_DIR" ]; then
  for EXTRAFILE in "$DOTFILES_EXTRA_DIR"/runcom/*.sh; do
    [ -f "$EXTRAFILE" ] && . "$EXTRAFILE"
  done
fi

# Miniconda Path
. /usr/local/miniconda3/etc/profile.d/conda.sh

# Clean up
unset READLINK CURRENT_SCRIPT SCRIPT_PATH DOTFILE EXTRAFILE

# Export
export DOTFILES_DIR DOTFILES_EXTRA_DIR
