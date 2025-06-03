# Runtime Configuration Files

This directory contains the runtime configuration files that get symlinked to the home directory.

## Files

- `.zshrc` - Main shell configuration and plugin setup
- `.p10k.zsh` - Powerlevel10k theme configuration
- `.latexmkrc` - LaTeX build system configuration

## Loading Order

1. `.zshrc` loads first and sets up the shell environment
2. Various plugin configurations are sourced
3. `.p10k.zsh` is loaded last to configure the prompt

## Notes

- Keep `.zshrc` lean by moving complex configurations to separate files
- Powerlevel10k instant prompt must remain at the top of `.zshrc`
- Conda initialization is placed at the end of `.zshrc` for performance
