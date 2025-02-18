-- https://github.com/mfussenegger/nvim-jdtls
--
-- Examples:
--
-- https://github.com/mfussenegger/dotfiles/blob/master/vim/dot-config/nvim/ftplugin/java.lua
-- https://github.com/gbroques/neovim-configuration/blob/master/ftplugin/java.lua

local jdtls = require 'jdtls'

-- vim.o.tabstop = 4

local config = {
  cmd = { '/opt/homebrew/bin/jdtls' },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  -- https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  settings = {
    java = {
      -- This is the default
      -- autobuild = { enabled = true },
    },
  },
  on_attach = function(client, bufnr)
    vim.keymap.set('n', '<leader>co', jdtls.organize_imports, { desc = 'Organize imports', buffer = bufnr })
    vim.keymap.set('n', '<leader>cv', jdtls.extract_variable_all, { desc = 'Extract variable', buffer = bufnr })
    vim.keymap.set('v', '<leader>cm', "<CMD>lua require('jdtls').extract_method(true)<CR>", { desc = 'Extract method', buffer = bufnr })
    vim.keymap.set('n', '<leader>cc', jdtls.extract_constant, { desc = 'Extract constant', buffer = bufnr })
    -- 2025-02-12: Tried to force a gradle build - doesn't work
    -- vim.api.nvim_create_autocmd('BufWritePost', {
    --   buffer = bufnr,
    --   callback = function()
    --     client.request_sync('java/buildWorkspace', false, 5000, bufnr)
    --   end,
    -- })
  end,
}
require('jdtls').start_or_attach(config)
