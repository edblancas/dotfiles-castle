-- everything inside plugin/*.lua will execute after you lazy config
local set = vim.keymap.set
set('n', '<space><space>x', '<cmd>source %<CR>', { desc = 'Source this buffer' })
set('n', '<space>x', ':.lua<CR>', { desc = 'Lua: source this line' })
set('v', '<space>x', ':lua<CR>', { desc = 'Lua: source this selection' })
set("n", "<M-j>", "<cmd>cnext<CR>", { desc = 'Next quick list entry' })
set("n", "<M-k>", "<cmd>cprev<CR>", { desc = 'Previous quick list entry' })
set("n", "-", "<cmd>Oil<CR>", { desc = 'Oil' })
set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlight search' })
set('n', '<M-,>', '<c-w>5<', { desc = 'Resize window left' })
set('n', '<M-.>', '<c-w>5>', { desc = 'Resize window right' })
set('n', '<M-t>', '<c-w>+', { desc = 'Resize window up' })
set('n', '<M-s>', '<c-w>-', { desc = 'Resize window down' })
