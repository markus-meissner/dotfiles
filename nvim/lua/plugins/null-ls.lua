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
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- list of formatters & linters for mason to install
    local formatters = {
      'checkmake',
      'prettier', -- ts/js formatter
      -- 'stylua',   -- lua formatter
      'eslint_d', -- ts/js linter
      'shfmt',
    }
    if vim.fn.executable 'unzip' == 1 and (vim.fn.has 'macunix' == 1 or vim.loop.os_uname().sysname == 'Linux') then
      vim.list_extend(formatters, {
        -- stylua does currently not support FreeBSD
        'stylua', -- Used to format Lua code
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
        if client.supports_method 'textDocument/formatting' then
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
  end,
}
