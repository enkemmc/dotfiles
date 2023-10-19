-- Read the docs: https://www.lunarvim.org/docs/configuration Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6 Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.wo.relativenumber = true

-- my plugins
lvim.plugins = {
  { "christoomey/vim-tmux-navigator" },
}

-- lsp
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "csharp_ls" }) -- overrides default c# lsp
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "omnisharp"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- transparency
lvim.transparent_window = true

-- keybinds
lvim.keys.insert_mode["jj"] = "<Esc>"
lvim.lsp.buffer_mappings.normal_mode["[g"] = { function() vim.diagnostic.goto_next({ severity = "ERROR" }) end,
  "Next Error" }
lvim.lsp.buffer_mappings.normal_mode["]g"] = { function() vim.diagnostic.goto_prev({ severity = "WARN" }) end,
  "Previous Warning" }

-- settings
lvim.format_on_save.enabled = true
lvim.lsp.installer.setup.automatic_installation = true
lvim.builtin.bufferline.active = false -- disable tabs
-- vim.cmd [[ set showtabline=0 ]] -- disable tabs

-- formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" },
  {
    name = "prettier",
    args = {
      "--arrow-parens", "always",
      "--bracket-spacing", "true",
      "--end-of-line", "lf",
      "--html-whitespace-sensitivity", "css",
      "--insert-pragma", "false",
      "--jsx-bracket-same-line", "false",
      "--jsx-single-quote", "false",
      "--print-width", "80",
      "--prose-wrap", "preserve",
      "--quote-props", "as-needed",
      "--require-pragma", "false",
      "--semi", "true",
      "--single-quote", "false",
      "--tab-width", "2",
      "--trailing-comma", "es5",
      "--use-tabs", "false",
      "--embedded-language-formatting", "auto",
      "--vue-indent-script-and-style", "false",
    },
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "css",
      "html",
    },
  }
}
