-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

require('options')

require('keymaps')

-- require("config.lazy")
if vim.fn.has 'nvim-0.12' == 1 then
  vim.pack.add({
    "https://github.com/gbprod/cutlass.nvim",
    "https://github.com/nvim-mini/mini.move",
  })

  require('cutlass').setup {
    cut_key = 'm',
  }

  require('mini.move').setup {
    -- Module mappings. Use `''` (empty string) to disable one.
    -- 2025-03-30: Left and right are not working for unknown reasons
    mappings = {
      -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      left = '<C-Left>',
      right = '<C-Right>',
      down = '<C-Down>',
      up = '<C-Up>',

      -- Move current line in Normal mode
      line_left = '<C-Left>',
      line_right = '<C-Right>',
      line_down = '<C-Down>',
      line_up = '<C-Up>',
    },
  }
end

-- vim: ts=2 sts=2 sw=2 et
