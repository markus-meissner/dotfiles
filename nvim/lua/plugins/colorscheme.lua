return {
  -- { -- You can easily change to a different colorscheme.
  --   -- Change the name of the colorscheme plugin below, and then
  --   -- change the command in the config to whatever the name of that colorscheme is.
  --   --
  --   -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  --   'folke/tokyonight.nvim',
  --   enabled = false,
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   init = function()
  --     -- Load the colorscheme here.
  --     -- Like many other themes, this one has different styles, and you could load
  --     -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  --     vim.cmd.colorscheme 'tokyonight-night'
  --
  --     -- You can configure highlights by doing something like:
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },

  -- { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  -- {
  --   'loctvl842/monokai-pro.nvim',
  --   enabled = false,
  --   config = function()
  --     require('monokai-pro').setup {
  --       day_night = {
  --         enable = true, -- turn off by default
  --         day_filter = 'light', -- classic | octagon | pro | machine | ristretto | spectrum
  --         night_filter = 'classic', -- classic | octagon | pro | machine | ristretto | spectrum
  --       },
  --     }
  --     vim.cmd.colorscheme 'monokai-pro'
  --   end,
  -- },
  -- { 'rose-pine/neovim' },

  {
    'maxmx03/solarized.nvim',
    enabled = true,
    lazy = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    ---@type solarized.config
    opts = {
      -- palette = 'selenized',
      -- variant = 'winter',
      -- 2025-08-24: Tried to change the background color, did't sucseed.
    },
    config = function(_, opts)
      vim.o.termguicolors = true
      require('solarized').setup(opts)
      vim.cmd.colorscheme 'solarized'
    end,
  },

  -- {
  --   'shaunsingh/solarized.nvim',
  --   lazy = false,
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   init = function()
  --     vim.cmd.colorscheme 'solarized'
  --   end,
  -- },
}
