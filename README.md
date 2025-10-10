# Dotfiles

Cross-platform configuration files for development tools and applications.

## Contents

### VSCode
- **settings.json** - Editor settings including vim keybindings
- **keybindings.json** - Custom keyboard shortcuts

#### Vim Keybindings Included
- Leader key: `<space>`
- `jj` in insert mode → Escape
- `K` → Show hover documentation
- `gi` → Go to implementation
- `gr` → Go to references
- `[g` / `]g` → Navigate errors
- `<leader>w` → Save file

## Installation

### Quick Start

```bash
cd ~/code/dotfiles
./install.sh
```

The install script will:
1. Detect your operating system (Linux, macOS, or Windows/WSL)
2. Backup your existing configuration files
3. Create symlinks from this repository to your VSCode config directory

### Platform-Specific Paths

The script automatically detects and uses the correct path:

- **Linux**: `~/.config/Code/User/`
- **macOS**: `~/Library/Application Support/Code/User/`
- **Windows (WSL)**: `/mnt/c/Users/{username}/AppData/Roaming/Code/User/`

### Manual Installation

If you prefer to manually create symlinks:

#### Linux
```bash
ln -sf ~/code/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json
ln -sf ~/code/dotfiles/vscode/keybindings.json ~/.config/Code/User/keybindings.json
```

#### macOS
```bash
ln -sf ~/code/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/code/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
```

#### Windows (WSL)
```bash
WIN_USER=$(cmd.exe /c "echo %USERNAME%" | tr -d '\r')
ln -sf ~/code/dotfiles/vscode/settings.json "/mnt/c/Users/$WIN_USER/AppData/Roaming/Code/User/settings.json"
ln -sf ~/code/dotfiles/vscode/keybindings.json "/mnt/c/Users/$WIN_USER/AppData/Roaming/Code/User/keybindings.json"
```

## Uninstallation

To remove symlinks and restore your configuration:

```bash
./uninstall.sh
```

This will:
- Remove symlinks that point to this dotfiles repository
- Leave backup files intact in `~/.dotfiles-backup-*` directories
- Preserve any settings that weren't symlinked

## Making Changes

Since these are symlinked files:

1. **Edit files in the dotfiles repo** - Changes are immediately reflected in VSCode
2. **Edit in VSCode** - Changes are immediately saved to the repo
3. **Commit and push** - Share your configurations across machines

### After Making Changes

```bash
cd ~/code/dotfiles
git add .
git commit -m "Update VSCode settings"
git push
```

### Setting Up on a New Machine

```bash
git clone <your-repo-url> ~/code/dotfiles
cd ~/code/dotfiles
./install.sh
```

## Backups

The install script automatically creates timestamped backups before creating symlinks:

- Backup location: `~/.dotfiles-backup-{timestamp}/`
- Only non-symlinked files are backed up
- Backups are never automatically deleted

## Troubleshooting

### Symlinks not working

Check if symlinks were created correctly:
```bash
ls -la ~/.config/Code/User/settings.json  # Linux
ls -la ~/Library/Application\ Support/Code/User/settings.json  # macOS
```

The output should show `->` pointing to your dotfiles directory.

### VSCode not picking up changes

1. Verify symlinks are correct
2. Reload VSCode window (Cmd/Ctrl+Shift+P → "Reload Window")
3. Check for VSCode errors in Developer Tools (Help → Toggle Developer Tools)

### Different VSCode installation (Insiders, VSCodium, etc.)

Edit the `VSCODE_PATH` variable in `install.sh` to point to your specific installation:
- VSCode Insiders: `Code - Insiders` instead of `Code`
- VSCodium: `VSCodium` instead of `Code`

## Repository Structure

```
dotfiles/
├── README.md              # This file
├── install.sh             # Cross-platform installation script
├── uninstall.sh           # Uninstallation script
└── vscode/
    ├── settings.json      # VSCode settings & vim bindings
    └── keybindings.json   # Custom keyboard shortcuts
```

## Future Additions

Consider adding:
- Bash/Zsh configurations (`.bashrc`, `.zshrc`)
- Git configuration (`.gitconfig`)
- Terminal configurations
- Other editor configs (`.vimrc`, etc.)
