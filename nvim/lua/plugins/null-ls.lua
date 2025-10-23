-- Format on save and linters
-- https://github.com/hendrikmi/dotfiles/blob/main/nvim/lua/plugins/none-ls.lua
return {
  -- null-ls.nvim Reloaded, maintained by the community.
  -- Only the repo name is changed for compatibility concerns.
  -- All the API and future changes will keep in place as-is.
  'nvimtools/none-ls.nvim',
  enabled = vim.fn.executable 'npm' == 1,
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jay-babu/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting   -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- list of formatters & linters for mason to install
    local formatters = {
      'prettier', -- ts/js formatter
      'eslint_d', -- ts/js linter
    }
    if vim.fn.executable 'unzip' == 1 and (vim.fn.has 'macunix' == 1 or vim.loop.os_uname().sysname == 'Linux') then
      vim.list_extend(formatters, {
        'checkmake',
        'stylua', -- Used to format Lua code
        'shfmt',  -- A shell parser, formatter, and interpreter
      })
    end
    if vim.fn.has 'macunix' == 1 then
      vim.list_extend(formatters, {
        -- ruff requires python3-venv on Debian. Add a matching check it needed.
        'ruff', -- Python linter and code formatter
      })
    end

    require('mason-null-ls').setup {
      ensure_installed = formatters,
      -- auto-install configured formatters & linters (with null-ls)
      automatic_installation = true,
    }

    local sources = {
      diagnostics.checkmake,
      -- 2025-05-07: Disable formatting (on save) for html files
      -- formatting.prettier.with { filetypes = { 'html', 'json', 'yaml', 'markdown' } },
      formatting.prettier.with { filetypes = { 'json', 'yaml', 'markdown' } },
      formatting.stylua,
      formatting.shfmt.with { args = { '-i', '4' } },
      formatting.terraform_fmt,
    }
    if vim.fn.has 'macunix' == 1 then
      vim.list_extend(sources, {
        -- see above
        require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
        require 'none-ls.formatting.ruff_format',
      })
    end

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
      -- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
      sources = sources,
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' and vim.bo.filetype == 'markdown' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = false }
            end,
          })
        end
      end,
    }
    -- Mapping must be added here and not via `keys = {`. Using `keys` leads to:
    -- [LSP] Format request failed, no matching language servers.
    --
    -- All other format options are availabe via gw
    vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { desc = 'Format' })
  end,
}
