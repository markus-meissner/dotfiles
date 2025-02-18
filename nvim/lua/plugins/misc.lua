return {
  { -- LSP diagnostics in virtual text at the top right of your screen
    'dgagn/diagflow.nvim',
    event = 'LspAttach', -- This is what I use personnally and it works great
    opts = {
      scope = 'cursor',
      show_borders = true,
    },
  },
  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  { -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
    config = function()
      vim.g.sleuth_bindzone_heuristics = 0
    end,
  },

  {
    'gbprod/cutlass.nvim',
    config = function()
      require('cutlass').setup {
        cut_key = 'm',
      }
    end,
  },

  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Find and replace
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup {
        -- options, see Configuration section below
        -- there are no required options atm
        -- engine = 'ripgrep' is default, but 'astgrep' can be specified
      }
    end,
  },

  {
    -- java
    'mfussenegger/nvim-jdtls',
  },

  {
    -- Save and restore cursor position
    'ecthelionvi/NeoView.nvim',
    opts = {},
  },

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

  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   lazy = false,
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   config = function()
  --     require("nvim-tree").setup({
  --       view = {
  --         adaptive_size = true,
  --       }
  --     })
  --   end,
  --   keys = {
  --     -- { "<leader>e", ":NvimTreeFindFileToggle<cr>", desc = "Toggle nvim-tree" },
  --     { "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle nvim-tree" },
  --   },
  -- },
}
