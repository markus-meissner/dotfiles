-- Autoformat
-- See also: null-ls.lua
return {
  'stevearc/conform.nvim',
  -- 2025-10-17: Disabled autoformat on save, this is anoying with old python scripts
  -- event = { 'BufWritePre' },
  -- 2025-10-21: Seems to be the same as null-ls / none-ls
  enabled = false,
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = nil,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      python = { 'isort', 'black' },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
