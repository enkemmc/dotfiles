" Neovim Configuration (VimScript)
" Converted from VSCode vim settings
" Note: For modern Neovim, init.lua is recommended

" ============================================================================
" General Settings
" ============================================================================

" Set leader key to space
let mapleader = " "
let maplocalleader = " "

" Line numbers
set number
set relativenumber

" System clipboard integration
set clipboard=unnamedplus

" ============================================================================
" Key Mappings
" ============================================================================

" Insert Mode Mappings
" jj to escape to normal mode
inoremap jj <Esc>

" Normal Mode Mappings
" Leader + w to save file
nnoremap <leader>w :w<CR>

" K to show hover documentation (LSP)
" This is often default with LSP, uncomment if needed:
" nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>

" Navigate to next/previous diagnostic (error/warning)
nnoremap <silent> ]g <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> [g <cmd>lua vim.diagnostic.goto_prev()<CR>

" LSP keybindings (requires LSP to be configured)
" Go to implementation
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>

" Go to references
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>

" ============================================================================
" Additional Recommended Settings (optional)
" ============================================================================

" Enable mouse support
set mouse=a

" Better search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Better editing experience
set expandtab
set smartindent
set tabstop=2
set shiftwidth=2

" Better splits
set splitright
set splitbelow

" Persistent undo
set undofile

" Better completion
set completeopt=menuone,noselect

" ============================================================================
" LSP Configuration (requires nvim-lspconfig plugin)
" ============================================================================

" Uncomment when you have LSP plugins installed:
" lua << EOF
" local on_attach = function(client, bufnr)
"   -- LSP keymaps are already defined above
" end
"
" require('lspconfig').tsserver.setup({ on_attach = on_attach })
" require('lspconfig').lua_ls.setup({ on_attach = on_attach })
" EOF
