-- Good source of inspiration:
-- ~/.local/share/nvim-lazyvim/lazy/LazyVim/lua/lazyvim/plugins/extras/editor/snacks_picker.lua
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = false }, -- replaced by mini-starter
    indent = { enabled = false }, -- replaced by mini-indentscope
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
  },
}
