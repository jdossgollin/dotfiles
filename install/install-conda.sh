#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "${SCRIPT_DIR}")"

# Install miniconda via Homebrew
brew install --cask miniconda

# Initialize conda for the current shell
eval "$(/opt/homebrew/bin/conda shell.bash hook)"

# for each file in the conda directory, create an environment
for env_file in "${DOTFILES_DIR}/conda/"*.yml; do
    # Check if the glob pattern actually matched any files
    if [[ ! -f "$env_file" ]]; then
        echo "No conda environment files found in ${DOTFILES_DIR}/conda/"
        break
    fi

    env_name=$(basename "${env_file}" .yml)
    echo "Creating conda environment: ${env_name}"
    conda env create -f "${env_file}" --name "${env_name}"
done
