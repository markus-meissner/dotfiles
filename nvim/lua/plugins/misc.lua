return {
  {
    'breard-r/vim-dnsserial',
  },

  { -- LSP diagnostics in virtual text at the top right of your screen
    'dgagn/diagflow.nvim',
    event = 'LspAttach', -- This is what I use personnally and it works great
    opts = {
      placement = 'inline',
      scope = 'cursor',
      show_borders = false,
    },
  },

  { -- Save and restore cursor position
    'ecthelionvi/NeoView.nvim',
    opts = {},
  },

  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  { -- Improved cut/paste / register handling
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

  { -- automatic session management
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      -- log_level = 'debug',
    },
  },

  { -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
    config = function()
      vim.g.sleuth_bindzone_heuristics = 0
    end,
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
