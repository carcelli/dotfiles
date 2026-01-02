#!/bin/bash

# Dotfiles installation script
# This script creates symlinks from your dotfiles to their expected locations

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

echo "Installing dotfiles from $DOTFILES_DIR"

# Create backup directory
mkdir -p "$BACKUP_DIR"
echo "Created backup directory: $BACKUP_DIR"

# Create necessary directories for configuration files
echo "Creating configuration directories..."
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/gh"
mkdir -p "$HOME/.cursor"
mkdir -p "$HOME/.vscode"

# List of files to symlink
files=(
    ".bashrc"
    ".zshrc"
    ".p10k.zsh"
    ".gitconfig"
    ".profile"
    ".bash_logout"
    ".cursor/cli-config.json"
    ".cursor/mcp.json"
    ".config/gh/config.yml"
    ".vscode/settings.json"
)

for file in "${files[@]}"; do
    src="$DOTFILES_DIR/$file"
    dest="$HOME/$file"

    # Check if source file exists
    if [[ ! -f "$src" ]]; then
        echo "Warning: $src does not exist, skipping..."
        continue
    fi

    # Handle existing destination (file, symlink, or directory)
    if [[ -L "$dest" ]]; then
        # Remove existing symlink
        echo "Removing existing symlink $dest"
        rm "$dest"
    elif [[ -f "$dest" ]]; then
        # Backup existing regular file
        echo "Backing up $dest to $BACKUP_DIR/"
        mv "$dest" "$BACKUP_DIR/"
    elif [[ -d "$dest" ]]; then
        # Remove existing directory (backup if it contains files)
        if [[ -n "$(ls -A "$dest" 2>/dev/null)" ]]; then
            echo "Backing up non-empty directory $dest to $BACKUP_DIR/"
            mv "$dest" "$BACKUP_DIR/"
        else
            echo "Removing empty directory $dest"
            rmdir "$dest"
        fi
    fi

    # Create symlink
    echo "Creating symlink: $dest -> $src"
    ln -s "$src" "$dest"
done

echo "Installation complete!"
echo "Backup of original files saved in: $BACKUP_DIR"
echo ""
echo "Next steps:"
echo "1. Restart your shell or run 'source ~/.bashrc' / 'source ~/.zshrc'"
echo "2. Install required dependencies:"
echo "   - Oh My Zsh: https://ohmyz.sh/"
echo "   - Powerlevel10k: git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k"
echo "   - NVM: https://github.com/nvm-sh/nvm#installing-and-updating"
echo "   - Conda/Miniconda/Anaconda"
