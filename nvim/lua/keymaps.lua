-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>qq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>qt', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = 'Toggle diagnostics' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Toggle line wrapping
vim.keymap.set('n', '<leader>bw', '<cmd>set wrap!<CR>')

-- Center cursor, thanks to ThePrimeagen
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

-- Open file under cursor in default app, mainly for opening http links in browser
-- There is the default binding gx which calls the deactivated netrw
-- https://sbulav.github.io/vim/neovim-opening-github-repos/
local function url_repo()
  local cursorword = vim.fn.expand '<cfile>'
  -- https://onecompiler.com/lua/43aaypgqy
  if string.find(cursorword, '^[%a%d%-]*/[%a%d%-%.]*$') then
    return 'https://github.com/' .. cursorword
  end
  if string.find(cursorword, '^MIT%-%d*$') then
    return os.getenv('MIT_IT') .. '/it/search?utf8=%E2%9C%93&scope=&q=' .. cursorword:match('^MIT%-(%d+)$')
  end
  return ''
end

local open_command = 'xdg-open'
if vim.fn.has 'mac' == 1 then
  open_command = 'open'
end
vim.keymap.set('n', 'go', function()
  vim.fn.jobstart({ open_command, url_repo() }, { detach = true })
end, { desc = 'Open in default app' })

-- vim.keymap.set('n', 'go', '<cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>', { desc = 'Open in default app' })

-- vim.keymap.set('n', '<leader>ll', function()
--   vim.lsp.enable('ltex_plus', not vim.lsp.is_enabled 'ltex_plus')
--   print(vim.lsp.is_enabled 'ltex_plus')
--   local clients = vim.lsp.get_clients { buffer = 0 }
--   for _, client in ipairs(clients) do
--     if client.name == 'ltex_plus' then
--       print 'Found ltex-ls'
--       client.config.settings.enable = true
--       -- vim.lsp.buf_notify(0, "workspace/didChangeConfiguration", { settings = client.config.settings })
--     end
--   end
-- end, { desc = 'Toggle LTeX LSP' })
