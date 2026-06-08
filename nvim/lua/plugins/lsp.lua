return { -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'mason-org/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      -- mason-lspconfig:
      -- - Bridges the gap between LSP config names (e.g. "lua_ls") and actual Mason package names (e.g. "lua-language-server").
      -- - Used here only to allow specifying language servers by their LSP name (like "lua_ls") in `ensure_installed`.
      -- - It does not auto-configure servers — we use vim.lsp.config() + vim.lsp.enable() explicitly for full control.
      'mason-org/mason-lspconfig.nvim',
      -- mason-tool-installer:
      -- - Installs LSPs, linters, formatters, etc. by their Mason package name.
      -- - We use it to ensure all desired tools are present.
      -- - The `ensure_installed` list works with mason-lspconfig to resolve LSP names like "lua_ls".
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      {
        'j-hui/fidget.nvim',
        opts = {
          notification = {
            window = {
              winblend = 0, -- Background color opacity in the notification window
            },
          },
        },
      },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          -- nvim-0.11 - map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gra', vim.lsp.buf.code_action, 'code [A]ction')
          map('gri', vim.lsp.buf.implementation, '[I]mplementation')
          map('grn', vim.lsp.buf.rename, 're[n]ame')
          map('grr', vim.lsp.buf.references, '[R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>cD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>cS', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          -- nvim-0.11 - nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>ch', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Change diagnostic symbols in the sign column (gutter)
      -- if vim.g.have_nerd_font then
      --   local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
      --   local diagnostic_signs = {}
      --   for type, icon in pairs(signs) do
      --     diagnostic_signs[vim.diagnostic.severity[type]] = icon
      --   end
      --   vim.diagnostic.config { signs = { text = diagnostic_signs } }
      -- end

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- ansiblels = {},
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --

        -- lua_ls = {
        --   -- cmd = { ... },
        --   -- filetypes = { ... },
        --   -- capabilities = {},
        --   settings = {
        --     Lua = {
        --       completion = {
        --         callSnippet = 'Replace',
        --       },
        --       -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        --       -- diagnostics = { disable = { 'missing-fields' } },
        --     },
        --   },
        -- },
        -- yamlls = {},
      }
      if vim.fn.has 'macunix' == 1 then
        servers['ansiblels'] = {}
        -- 2025-10-22: Can't get marksman to complete filenames
        -- servers['marksman'] = {}

        -- LTEX+ Language Server, grammar and spell check
        -- vim.lsp.config('ltex_plus', {
        --   settings = {
        --     ltex = {
        --       checkFrequency = 'save',
        --       -- enabled = { 'markdown', 'plaintex', 'rst', 'tex', 'latex' },
        --       enabled = false,
        --       -- https://ltex-plus.github.io/ltex-plus/settings.html#ltexlanguage
        --       -- Use a specific variant like "en-US" or "de-DE" instead of the
        --       -- generic language code like "en" or "de" to obtain spelling
        --       -- corrections (in addition to grammar corrections).
        --       -- language = 'de-DE',
        --       -- language = 'en-EN',
        --       -- <!-- LTeX: language=de-DE -->
        --     },
        --   },
        -- })
      end
      if vim.fn.has 'macunix' == 1 or vim.loop.os_uname().sysname == 'Linux' then
        -- LuaLS does currently not support FreeBSD
        -- https://github.com/LuaLS/lua-language-server/discussions/2837
        servers['lua_ls'] = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        }
      end
      if vim.fn.executable 'ruff' == 1 then
        -- We use ruff and pylsp:
        -- - ruff is the fastes, but only supports linting and formatting
        -- - pylsp seems to be better than pyright
        -- - Use pylsp for rope integration later
        --
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#pylsp
        --
        servers['ruff'] = {
          -- config doesn't work, we should probably switch to vim.lsp.config
          ruff = {
            init_options = {
              settings =  {
                configuration = {
                  lint = {
                    ["select"] = {"E","F","N","W"}
                  }
                }
              }
            }
          }
        }
        -- 2025-12-09: It seems that the settings here are ignored as pycodestyle still pops up
        -- servers['pylsp'] = {
        --   settings = {
        --     -- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
        --     pylsp = {
        --       plugins = {
        --         autopep8 = { enabled = false },
        --         mccabe = { enabled = false },
        --         pycodestyle = { enabled = false },
        --         pyflakes = { enabled = false },
        --         pylsp_black = { enabled = false },
        --         -- pylsp_isort = { enabled = false },
        --         -- pylsp_mypy = { enabled = false },
        --         yapf = { enabled = false },
        --       },
        --     },
        --   },
        -- }
      end

      if vim.fn.executable 'npm' == 1 then
        servers['yamlls'] = {}
      end

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.

      local ensure_installed = vim.tbl_keys(servers or {})
      if vim.fn.executable 'unzip' == 1 and (vim.fn.has 'macunix' == 1 or vim.loop.os_uname().sysname == 'Linux') then
        vim.list_extend(ensure_installed, {
          -- stylua does currently not support FreeBSD
          'stylua', -- Used to format Lua code
        })
      end
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      for server, cfg in pairs(servers) do
        -- For each LSP server (cfg), we merge:
        -- 1. A fresh empty table (to avoid mutating capabilities globally)
        -- 2. Your capabilities object with Neovim + cmp features
        -- 3. Any server-specific cfg.capabilities if defined in `servers`
        cfg.capabilities = vim.tbl_deep_extend('force', {}, capabilities, cfg.capabilities or {})

        vim.lsp.config(server, cfg)
        vim.lsp.enable(server)
      end
    end,
  },
}
