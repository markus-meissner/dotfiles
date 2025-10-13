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

  -- Automatic list continuation and formatting ===============================
  {
    'gaoDean/autolist.nvim',
    ft = {
      'markdown',
    },
    config = function()
      require('autolist').setup()

      vim.keymap.set('i', '<tab>', '<cmd>AutolistTab<cr>')
      vim.keymap.set('i', '<s-tab>', '<cmd>AutolistShiftTab<cr>')
      -- vim.keymap.set("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>") -- an example of using <c-t> to indent
      vim.keymap.set('i', '<CR>', '<CR><cmd>AutolistNewBullet<cr>')
      vim.keymap.set('n', 'o', 'o<cmd>AutolistNewBullet<cr>')
      vim.keymap.set('n', 'O', 'O<cmd>AutolistNewBulletBefore<cr>')
      -- 2025-10-06: This doesn't work for unknown reasons
      vim.keymap.set('n', '<CR>', '<cmd>AutolistToggleCheckbox<CR><CR>')
      vim.keymap.set('n', '<leader>ct', '<cmd>AutolistToggleCheckbox<CR><CR>')
      vim.keymap.set('n', 't', '<cmd>AutolistToggleCheckbox<CR><CR>')
      -- vim.keymap.set('n', '<leader>ct', '<cmd>AutolistToggleCheckbox<CR><CR>', desc = 'Markdown [t]oggle checkbox')

      vim.keymap.set('n', '<CR>', '<cmd>AutolistToggleCheckbox<CR><CR>')
      -- vim.keymap.set('n', '<C-r>', '<cmd>AutolistRecalculate<cr>')

      -- cycle list types with dot-repeat
      -- vim.keymap.set('n', '<leader>cn', require('autolist').cycle_next_dr, { expr = true })
      -- vim.keymap.set('n', '<leader>cp', require('autolist').cycle_prev_dr, { expr = true })
      -- if you don't want dot-repeat
      -- vim.keymap.set("n", "<leader>cn", "<cmd>AutolistCycleNext<cr>")
      -- vim.keymap.set("n", "<leader>cp", "<cmd>AutolistCycleNext<cr>")

      -- functions to recalculate list on edit
      -- vim.keymap.set('n', '>>', '>><cmd>AutolistRecalculate<cr>')
      -- vim.keymap.set('n', '<<', '<<<cmd>AutolistRecalculate<cr>')
      -- vim.keymap.set('n', 'dd', 'dd<cmd>AutolistRecalculate<cr>')
      -- vim.keymap.set('v', 'd', 'd<cmd>AutolistRecalculate<cr>')
    end,
  },

  -- Generate and update table of contents list (TOC) for markdown ============
  {
    'hedyhli/markdown-toc.nvim',
    ft = 'markdown',  -- Lazy load on markdown filetype
    cmd = { 'Mtoc' }, -- Or, lazy load on "Mtoc" command
    opts = {
      toc_list = {
        markers = '-',
      },
    },
    keys = {
      { '<leader>cc', '<Cmd>Mtoc<CR>', desc = 'Markdown table of [c]ontent' },
    },
  },

  -- Follow links in markdown =================================================
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
  -- Replaced by 'gaoDean/autolist.nvim'
  {
    'tadmccorkle/markdown.nvim',
    enabled = false,
    ft = 'markdown', -- or 'event = "VeryLazy"'
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
