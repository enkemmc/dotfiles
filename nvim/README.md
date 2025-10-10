# Neovim Configuration

Neovim configuration converted from VSCode vim keybindings.

## Configuration Files

### init.lua (Recommended - Modern Lua config)
- **Location**: `~/.config/nvim/init.lua`
- Uses modern Lua API
- Better performance and flexibility
- Recommended for Neovim 0.5+

### init.vim (Alternative - Traditional VimScript)
- **Location**: `~/.config/nvim/init.vim`
- Uses traditional VimScript syntax
- Better compatibility with older Vim configurations
- Can coexist with `lua/` directory for hybrid configs

**Note**: Use **either** `init.lua` **or** `init.vim`, not both (init.lua takes precedence).

## Installation

### Linux / macOS
```bash
# Using init.lua (recommended)
mkdir -p ~/.config/nvim
ln -sf ~/code/dotfiles/nvim/init.lua ~/.config/nvim/init.lua

# OR using init.vim
mkdir -p ~/.config/nvim
ln -sf ~/code/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
```

### Windows
```powershell
# Using init.lua (recommended)
New-Item -ItemType Directory -Force -Path "$env:LOCALAPPDATA\nvim"
New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim\init.lua" -Target "$HOME\code\dotfiles\nvim\init.lua"

# OR using init.vim
New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim\init.vim" -Target "$HOME\code\dotfiles\nvim\init.vim"
```

## Keybindings Converted

All your VSCode vim keybindings have been converted:

### Insert Mode
- `jj` → Escape to normal mode

### Normal Mode
- `<space>` → Leader key
- `<leader>w` → Save file (`:w`)
- `K` → Show hover documentation (LSP)
- `[g` → Previous diagnostic/error
- `]g` → Next diagnostic/error
- `gi` → Go to implementation (LSP)
- `gr` → Go to references (LSP)

### Editor Settings
- Relative line numbers enabled
- System clipboard integration enabled

## LSP (Language Server Protocol) Support

The `gi`, `gr`, `K`, `[g`, and `]g` keybindings require LSP to be configured.

### Quick LSP Setup

For a minimal LSP setup, install [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig):

#### Using lazy.nvim (recommended plugin manager)

1. Add to your `init.lua`:
```lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
require("lazy").setup({
  { "neovim/nvim-lspconfig" },
})

-- Configure LSP
local lspconfig = require('lspconfig')
lspconfig.tsserver.setup({})  -- TypeScript
lspconfig.lua_ls.setup({})     -- Lua
lspconfig.pyright.setup({})    -- Python
-- Add more language servers as needed
```

2. Install language servers:
```bash
# TypeScript/JavaScript
npm install -g typescript typescript-language-server

# Lua
brew install lua-language-server  # macOS
# or download from: https://github.com/LuaLS/lua-language-server

# Python
pip install pyright
```

## Differences from VSCode Vim

### What Works the Same
- All basic vim motions and commands
- Your custom keybindings
- Insert mode mappings

### What's Different
- **Native vim**: No VSCode-specific commands
- **LSP required**: `gi`, `gr`, `K` need LSP plugins (not built-in like VSCode)
- **Faster**: No Electron overhead
- **More customizable**: Direct access to Neovim's API

### Missing VSCode Features
These VSCode-specific settings have no direct equivalent:
- `vim.argumentObjectOpeningDelimiters` / `vim.argumentObjectClosingDelimiters`
  - Use plugins like [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) for similar functionality

## Recommended Plugins

To get closer to your VSCode experience:

```lua
require("lazy").setup({
  -- LSP
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },  -- LSP installer
  { "williamboman/mason-lspconfig.nvim" },

  -- Autocompletion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },

  -- Syntax highlighting
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- File navigation
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Git integration
  { "lewis6991/gitsigns.nvim" },

  -- Status line
  { "nvim-lualine/lualine.nvim" },
})
```

## Testing Your Config

1. Open Neovim: `nvim`
2. Check health: `:checkhealth`
3. Test keybindings:
   - Type some text, then `jj` to escape
   - Press `<space>w` to save
   - Open a file with LSP support and test `gi`, `gr`, `K`

## Troubleshooting

### Keybindings not working
```vim
:verbose map <key>  " Check if key is mapped and where
:map                " List all mappings
```

### LSP not working
```vim
:LspInfo            " Check LSP status
:checkhealth lsp    " Diagnose LSP issues
```

### Config not loading
```bash
nvim --startuptime startup.log  # Check what's loading
```

## Migration Tips

### From VSCode to Neovim

1. **Start simple**: Use this basic config first
2. **Add LSP**: Install nvim-lspconfig for language features
3. **Add plugins gradually**: Don't install everything at once
4. **Use VSCode when needed**: It's okay to use both!

### Hybrid Approach

Many developers use:
- **VSCode** for large projects with complex debugging
- **Neovim** for quick edits, server work, and speed

You can maintain both configs in this dotfiles repo!
