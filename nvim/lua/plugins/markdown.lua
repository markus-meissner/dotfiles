return {

  -- See lint.lua for autocmd

  -- { -- automated bullet lists including toggle for checkbox ===================
  --   'bullets-vim/bullets.vim',
  --   -- We format the buffer on save (see lint.lua), there we get indent off
  --   -- list items.
  --   --
  --   -- Currently all functions except toogle checkbox doesn't seem to work.
  --   config = function()
  --     --   vim.opt.bullets_set_mappings = 0,
  --     -- vim.opt.bullets_checkbox_markers = ' .oOx'
  --   end,
  --   keys = {
  --     { '<leader>ct', '<Plug>(bullets-toggle-checkbox)', desc = 'Markdown [t]oggle checkbox' },
  --   },
  -- },

  -- { -- fluent navigation
  --   'jakewvincent/mkdnflow.nvim',
  --   config = function()
  --     require('mkdnflow').setup {
  --       -- Config goes here; leave blank for defaults
  --     }
  --   end,
  -- },

  -- Follow links in markdown==================================================
  {
    'jghauser/follow-md-links.nvim',
    enabled = vim.fn.has 'mac' == 1,
  },

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

  -- Configurable tools for markdown ==========================================
  {
    'tadmccorkle/markdown.nvim',
    ft = 'markdown', -- or 'event = "VeryLazy"'
    config = function()
      require('markdown').setup {
        mappings = {
          link_add = '<leader>cl', -- (string|boolean) add link
        },
      }
    end,
    opts = {
      on_attach = function(bufnr)
        local map = vim.keymap.set
        local opts = { buffer = bufnr }
        map({ 'n', 'i' }, '<M-l><M-o>', '<Cmd>MDListItemBelow<CR>', opts)
        map({ 'n', 'i' }, '<M-L><M-O>', '<Cmd>MDListItemAbove<CR>', opts)
        map('n', '<M-c>', '<Cmd>MDTaskToggle<CR>', opts)
        map('x', '<M-c>', ':MDTaskToggle<CR>', opts)
      end,
    },
    keys = {
      { '<leader>ct', '<Cmd>MDTaskToggle<CR>',    desc = 'Markdown [t]oggle checkbox' },
      { '<leader>ci', '<Cmd>MDListItemBelow<CR>', desc = 'Markdown list item' },
    },
  },
}
