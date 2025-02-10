return {
  -- Collection of various small independent plugins/modules
  --
  -- 2025-02-10: Couldn't get the config for mini.files to work here, so it
  -- has been moved to
  -- - mini.files.lua
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Navigate and manipulate file system
    -- require('mini.files').setup()
    -- 2025-02-10: Couldn't get the config for mini.files to work here, so it
    -- has been moved to `mini.files.lua`

    -- Visualize and work with indent scope
    require('mini.indentscope').setup()

    -- Text edit operators: Replace, multiple (duplicate) or sort text
    require('mini.operators').setup()

    -- Minimal and fast autopairs
    require('mini.pairs').setup()

    -- Fast and flexible start screen / dashboard
    require('mini.starter').setup()

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- Work with trailing whitespace
    require('mini.trailspace').setup()

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
