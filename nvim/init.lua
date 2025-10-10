-- Neovim Configuration (Lua)
-- Converted from VSCode vim settings

-- ============================================================================
-- General Settings
-- ============================================================================

-- Set leader key to space (must be set before any mappings)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- System clipboard integration
vim.opt.clipboard = "unnamedplus"

-- ============================================================================
-- Key Mappings
-- ============================================================================

-- Insert Mode Mappings
-- jj to escape to normal mode
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, desc = 'Exit insert mode' })

-- Normal Mode Mappings
-- Leader + w to save file
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true, desc = 'Save file' })

-- K to show hover documentation (LSP) - This is often default in LSP configs
-- Uncomment if you need to explicitly set it:
-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, desc = 'Show hover documentation' })

-- Navigate to next/previous diagnostic (error/warning)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, { noremap = true, silent = true, desc = 'Next diagnostic' })
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = 'Previous diagnostic' })

-- LSP keybindings (these require LSP to be configured)
-- Go to implementation
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { noremap = true, silent = true, desc = 'Go to implementation' })

-- Go to references
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true, silent = true, desc = 'Go to references' })

-- ============================================================================
-- Additional Recommended Settings (optional)
-- ============================================================================

-- Enable mouse support
vim.opt.mouse = 'a'

-- Better search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Better editing experience
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Better splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Persistent undo
vim.opt.undofile = true

-- Better completion
vim.opt.completeopt = 'menuone,noselect'

-- ============================================================================
-- LSP Configuration (requires nvim-lspconfig plugin)
-- ============================================================================

-- Uncomment and configure when you install LSP plugins:
--[[
local on_attach = function(client, bufnr)
  -- LSP keymaps are already defined above, but you can add more here
  -- Example:
  -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
  -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr })
end

-- Configure your language servers here
-- require('lspconfig').tsserver.setup({ on_attach = on_attach })
-- require('lspconfig').lua_ls.setup({ on_attach = on_attach })
]]

-- ============================================================================
-- Plugin Manager (optional - using lazy.nvim as example)
-- ============================================================================

-- Uncomment to bootstrap lazy.nvim plugin manager:
--[[
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Add your plugins here
  -- { "neovim/nvim-lspconfig" },
  -- { "hrsh7th/nvim-cmp" },
  -- { "nvim-telescope/telescope.nvim" },
})
]]
