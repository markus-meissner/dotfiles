-- [[ Setting options ]]
-- See `:help vim.opt`

-- Disable netrw in favor of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
if vim.fn.has 'mac' == 0 then
  vim.opt.mouse = ''
end

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- 2025-01-15: Disabled
-- 2025-01-24: Enabled
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
-- 2025-02-10: Disabled
vim.opt.undofile = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Tabs
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- vim.o.wrap = false -- display lines as one long line
-- vim.o.linebreak = true -- companion to wrap don't split words

-- Folds ======================================================================
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
if vim.fn.has 'nvim-0.10' == 1 then
  -- vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  -- vim.o.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  -- vim.o.foldmethod = 'expr'
  -- 2025-05-04: Currently indent seem to work for all my usecases
  vim.o.foldmethod = 'indent'
  vim.o.foldtext = '' -- Use underlying text with its highlighting
else
  vim.o.foldmethod = 'indent'
  vim.o.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end

vim.o.foldlevel = 99       -- Open all folds by default
-- vim.o.foldnestmax = 10      -- Create folds only for some number of nested levels
vim.g.markdown_folding = 1 -- Use folding by heading in markdown files

-- Virtual lines ==============================================================
-- lsp_lines.nvim is included in nvim-0.11, enable it
if vim.fn.has 'nvim-0.11' == 1 then
  vim.diagnostic.config {
    virtual_lines = true,
  }
end
