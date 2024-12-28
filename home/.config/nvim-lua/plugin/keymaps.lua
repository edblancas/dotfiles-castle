-- everything inside plugin/*.lua will execute after you lazy config
local set = vim.keymap.set
set('n', '<space><space>x', '<cmd>source %<CR>', { desc = 'source this buffer' })
set('n', '<space>x', ':.lua<CR>', { desc = 'lua: source this line' })
set('v', '<space>x', ':lua<CR>', { desc = 'lua: source this selection' })
set("n", "<M-j>", "<cmd>cnext<CR>", { desc = 'next quick list entry' })
set("n", "<M-k>", "<cmd>cprev<CR>", { desc = 'previous quick list entry' })
set("n", "-", "<cmd>Oil<CR>", { desc = 'Oil' })
