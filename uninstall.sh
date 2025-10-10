#!/bin/bash

# Dotfiles uninstallation script
# Removes symlinks and optionally restores backups

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect OS and set VSCode config path
detect_vscode_path() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Check if running in WSL
        if grep -qi microsoft /proc/version 2>/dev/null; then
            print_info "Detected WSL environment"
            WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
            if [ -n "$WIN_USER" ]; then
                VSCODE_PATH="/mnt/c/Users/$WIN_USER/AppData/Roaming/Code/User"
            else
                print_error "Could not determine Windows username"
                return 1
            fi
        else
            print_info "Detected Linux environment"
            VSCODE_PATH="$HOME/.config/Code/User"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        print_info "Detected macOS environment"
        VSCODE_PATH="$HOME/Library/Application Support/Code/User"
    else
        print_error "Unsupported operating system: $OSTYPE"
        return 1
    fi

    echo "$VSCODE_PATH"
}

# Remove symlink if it points to dotfiles
remove_symlink() {
    local file=$1
    local dotfiles_target=$2

    if [ -L "$file" ]; then
        local link_target=$(readlink "$file")
        if [[ "$link_target" == "$dotfiles_target" ]]; then
            rm "$file"
            print_info "Removed symlink: $file"
        else
            print_warn "Skipping $file (points to different location: $link_target)"
        fi
    elif [ -e "$file" ]; then
        print_warn "Skipping $file (not a symlink)"
    else
        print_info "File doesn't exist: $file"
    fi
}

# Main uninstallation
main() {
    print_info "Starting dotfiles uninstallation..."
    print_info "Dotfiles directory: $DOTFILES_DIR"

    # Detect VSCode path
    VSCODE_PATH=$(detect_vscode_path)
    if [ $? -ne 0 ]; then
        print_error "Failed to detect VSCode configuration path"
        exit 1
    fi

    print_info "VSCode config path: $VSCODE_PATH"

    # Remove VSCode symlinks
    if [ -d "$VSCODE_PATH" ]; then
        print_info "Removing VSCode configuration symlinks..."

        remove_symlink "$VSCODE_PATH/settings.json" "$DOTFILES_DIR/vscode/settings.json"
        remove_symlink "$VSCODE_PATH/keybindings.json" "$DOTFILES_DIR/vscode/keybindings.json"
    fi

    print_info "Uninstallation complete!"
    print_warn "Note: Backup files in ~/.dotfiles-backup-* were not removed"
    print_warn "You can manually restore them if needed"
}

main "$@"
