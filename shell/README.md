# Shell Configuration

Shell aliases and configurations for Zsh and Bash.

## Contents

### .aliases

A collection of useful shell aliases for common tasks and directory navigation.

#### File Listing Aliases

- `lt` - List files sorted by modification time (`ls -lt`)
- `ll` - Detailed list of all files including hidden (`ls -alF`)
- `la` - List all files including hidden (`ls -A`)
- `l` - Compact list view (`ls -CF`)

#### Directory Navigation

Quick navigation shortcuts using `pushd` for common project directories:

**Language-specific directories:**
- `nodedir` - Jump to ~/code/node
- `rustdir` - Jump to ~/code/rust
- `csdir` - Jump to ~/code/cs
- `ktdir` - Jump to ~/code/kotlin

**Project-specific shortcuts:**
- `gator` - Jump to ~/code/node/Gator
- `rclient` - Jump to ~/code/node/revzn-client
- `rjobs` - Jump to ~/code/node/revzn-jobserver
- `rapi` - Jump to ~/code/node/revzn-api-ts
- `rlocal` - Jump to ~/code/node/revzn-local-dev
- `rk8` - Jump to ~/code/node/revzn-k8
- `rtypes` - Jump to ~/code/node/revzn-types

#### Tool Aliases

- `dc` - Shortcut for `docker compose`
- `claude` - Run Claude CLI directly

## Installation

The `.aliases` file is symlinked to `~/.aliases` during installation.

### Automatic Installation

Run the install script from the dotfiles repository root:

```bash
./install.sh
```

### Manual Installation

Create a symlink to the aliases file:

```bash
ln -sf ~/code/dotfiles/shell/.aliases ~/.aliases
```

### Shell Configuration

Make sure your shell configuration file sources the aliases:

**For Zsh (~/.zshrc):**
```bash
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi
```

**For Bash (~/.bashrc):**
```bash
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi
```

## Customization

### Adding New Aliases

1. Edit `shell/.aliases` in the dotfiles repository
2. Changes are immediately available in new shell sessions
3. Reload current session: `source ~/.aliases`
4. Commit and push changes to sync across machines

### Removing Aliases

Simply delete or comment out the alias in `shell/.aliases` and reload your shell.

## Usage Tips

### Directory Navigation with pushd

The directory navigation aliases use `pushd` instead of `cd`, which:
- Pushes the current directory onto a stack
- Allows you to return to previous directories with `popd`
- View the directory stack with `dirs`

Example:
```bash
$ pwd
/home/user

$ nodedir
/home/user/code/node

$ popd
/home/user
```

### Reloading Aliases

After making changes to `.aliases`, reload them in your current shell:

```bash
source ~/.aliases
```

Or simply open a new shell session.

## Compatibility

- Works with both Zsh and Bash
- Cross-platform (Linux, macOS, WSL)
- No external dependencies required
