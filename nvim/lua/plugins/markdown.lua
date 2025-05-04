return {

  -- See lint.lua for autocmd

  { -- automated bullet lists including toggle for checkbox ===================
    'bullets-vim/bullets.vim',
    -- We format the buffer on save (see lint.lua), there we get indent off
    -- list items.
    --
    -- Currently all functions except toogle checkbox doesn't seem to work.
    config = function()
      --   vim.opt.bullets_set_mappings = 0,
      -- vim.opt.bullets_checkbox_markers = ' .oOx'
    end,
    keys = {
      { '<leader>ct', '<Plug>(bullets-toggle-checkbox)', desc = 'Markdown [t]oggle checkbox' },
    },
  },

  -- {
  --   'jakewvincent/mkdnflow.nvim',
  --   config = function()
  --     require('mkdnflow').setup {
  --       -- Config goes here; leave blank for defaults
  --     }
  --   end,
  -- },

  -- Markdown renderer ========================================================
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      bullet = {
        enabled = false,
      },
    },
  },
}
