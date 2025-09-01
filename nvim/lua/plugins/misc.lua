return {
  { -- Update bind zone serial automatically ===================================
    'breard-r/vim-dnsserial',
  },

  -- { -- LSP diagnostics in virtual text at the top right of your screen
  --   'dgagn/diagflow.nvim',
  --   event = 'LspAttach',
  --   opts = {
  --     placement = 'inline',
  --     scope = 'cursor',
  --     show_borders = false,
  --   },
  -- },

  -- Save and restore cursor position plugins
  -- [defaults: restore cursor position when opening a file · Issue #16339 · neovim/neovim · GitHub](https://github.com/neovim/neovim/issues/16339)
  --
  -- { -- Save and restore cursor position
  -- Using this plugin leads to the problem that live_grep doesn't take us to the right line:
  -- [Telescope doesn&#39;t bring me to the grepped line. · Issue #2 · ecthelionvi/NeoView.nvim · GitHub](https://github.com/ecthelionvi/NeoView.nvim/issues/2)
  --   'ecthelionvi/NeoView.nvim',
  --   opts = {},
  -- },

  { -- Save and restore cursor position
    'ethanholz/nvim-lastplace',
    config = function()
      require('nvim-lastplace').setup {}
    end,
  },

  -- navigate your code with search labels, enhanced character motions ========
  -- {
  --   'folke/flash.nvim',
  -- },

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

  { -- LSP diagnostics in virtual lines ========================================
    -- This plugin is included in neovim 0.11, see
    -- https://gpanders.com/blog/whats-new-in-neovim-0-11/#virtual-lines
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    enabled = vim.fn.has 'nvim-0.11' == 0,
    config = function()
      -- require('lsp_lines').setup {}
      vim.diagnostic.config {
        virtual_text = false,
      }
    end,
  },

  -- Surround selections, stylishly ===========================================
  --
  -- Use `(` if you want to add spaces, use `)` for no spaces.
  --
  --     Old text                    Command         New text
  -- -----------------------------------------------------------------
  -- surr*ound_words             ysiw)           (surround_words)
  -- *make strings               ys$"            "make strings"
  -- [delete ar*ound me!]        ds]             delete around me!
  -- remove <b>HTML t*ags</b>    dst             remove HTML tags
  -- 'change quot*es'            cs'"            "change quotes"
  -- <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
  -- delete(functi*on calls)     dsf             function calls
  --
  -- https://github.com/kylechui/nvim-surround/blob/main/doc/nvim-surround.txt
  {
    'kylechui/nvim-surround',
    -- version = '^3.0.0', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        keymaps = {
          insert = '<C-g>s',
          insert_line = '<C-g>S',
          normal = 'sa',
          normal_cur = 'yss',
          normal_line = 'yS',
          normal_cur_line = 'ySS',
          visual = 'S',
          visual_line = 'gS',
          delete = 'sd',
          change = 'sc',
          change_line = 'sC',
        },
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

  -- 2025-03-27: Never used, disabled for now.
  -- { -- Find and replace
  --   'MagicDuck/grug-far.nvim',
  --   config = function()
  --     require('grug-far').setup {
  --       -- options, see Configuration section below
  --       -- there are no required options atm
  --       -- engine = 'ripgrep' is default, but 'astgrep' can be specified
  --     }
  --   end,
  -- },

  { -- java
    'mfussenegger/nvim-jdtls',
  },

  { -- Status line ============================================================
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          -- this uses the configured colorscheme if installed
          theme = 'solarized',
          -- this uses solarized from lualine
          -- theme = require 'lualine.themes.solarized',
        },
        -- Show abbreviated mode
        sections = {
          lualine_a = {
            {
              'mode',
              fmt = function(str)
                return str:sub(1, 1)
              end,
              -- icon = '',
            },
          },
        },
      }
    end,
  },

  { -- automatic session management
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      allowed_dirs = { '~/dev/*', '~/Desktop/*' },
      -- suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      -- log_level = 'debug',
    },
  },

  -- Autoclose buffers / tabs =================================================
  {
    'sontungexpt/buffer-closer',
    enabled = vim.fn.has 'mac' == 1,
    event = 'VeryLazy',
    config = function()
      require('buffer-closer').setup {
        min_remaining_buffers = 5,
        excluded = {
          filenames = { 'Wochenziele.md' },
        },
      }
    end,
  },

  -- Marks ====================================================================
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    enabled = false,
    --enabled = vim.fn.has 'mac' == 1,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup {}
      --vim.keymap.set('n', '<leader>M', function()
      --  harpoon.ui:toggle_quick_menu(harpoon:list())
      --end)

      --vim.keymap.set('n', '<leader>m', function()
      --  harpoon:list():add()
      --end)
    end,
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
