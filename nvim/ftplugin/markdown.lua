vim.o.wrap = false     -- display lines as one long line
vim.o.linebreak = true -- companion to wrap don't split words
vim.o.textwidth = 80

-- Disable autocomplete / code suggestions in textfiles.
-- Enable via <leader>cd
require('cmp').setup.buffer { enabled = false }
