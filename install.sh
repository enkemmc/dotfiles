#!/bin/bash

# Dotfiles installation script
# Supports Linux, macOS, and Windows (WSL)

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

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
            # Try to find Windows username
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

# Backup existing file if it exists and is not a symlink
backup_file() {
    local file=$1
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        mkdir -p "$BACKUP_DIR"
        print_info "Backing up $(basename "$file") to $BACKUP_DIR"
        cp "$file" "$BACKUP_DIR/$(basename "$file")"
    fi
}

# Create symlink
create_symlink() {
    local source=$1
    local target=$2

    # Backup existing file
    backup_file "$target"

    # Remove existing file/symlink
    if [ -e "$target" ] || [ -L "$target" ]; then
        rm "$target"
    fi

    # Create symlink
    ln -sf "$source" "$target"
    print_info "Created symlink: $target -> $source"
}

# Main installation
main() {
    print_info "Starting dotfiles installation..."
    print_info "Dotfiles directory: $DOTFILES_DIR"

    # Detect VSCode path
    VSCODE_PATH=$(detect_vscode_path)
    if [ $? -ne 0 ]; then
        print_error "Failed to detect VSCode configuration path"
        exit 1
    fi

    print_info "VSCode config path: $VSCODE_PATH"

    # Create VSCode config directory if it doesn't exist
    if [ ! -d "$VSCODE_PATH" ]; then
        print_warn "VSCode config directory doesn't exist. Creating it..."
        mkdir -p "$VSCODE_PATH"
    fi

    # Install VSCode settings
    if [ -d "$DOTFILES_DIR/vscode" ]; then
        print_info "Installing VSCode configurations..."

        if [ -f "$DOTFILES_DIR/vscode/settings.json" ]; then
            create_symlink "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_PATH/settings.json"
        fi

        if [ -f "$DOTFILES_DIR/vscode/keybindings.json" ]; then
            create_symlink "$DOTFILES_DIR/vscode/keybindings.json" "$VSCODE_PATH/keybindings.json"
        fi
    fi

    # Install Shell configurations
    if [ -d "$DOTFILES_DIR/shell" ]; then
        print_info "Installing Shell configurations..."

        if [ -f "$DOTFILES_DIR/shell/.aliases" ]; then
            create_symlink "$DOTFILES_DIR/shell/.aliases" "$HOME/.aliases"
        fi
    fi

    print_info "Installation complete!"
    if [ -d "$BACKUP_DIR" ]; then
        print_info "Backups saved to: $BACKUP_DIR"
    fi
}

main "$@"
