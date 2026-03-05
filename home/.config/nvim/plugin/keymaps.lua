local set = vim.keymap.set
set('n', '<space>xf', '<cmd>source %<CR>', { desc = 'Source this buffer' })
set('n', '<space>xx', ':.lua<CR>', { desc = 'Lua: source this line' })
set('v', '<space>x', ':lua<CR>', { desc = 'Lua: source this selection' })
set("n", "-", "<cmd>Oil<CR>", { desc = 'Oil' })
set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlight search' })
set('n', '<M-(>', '<c-w>5<', { desc = 'Decrease current window width' })
set('n', '<M-)>', '<c-w>5>', { desc = 'Increase current window width' })
set('n', '<M-+>', '<c-w>+', { desc = 'Increase current window height' })
set('n', '<M-_>', '<c-w>-', { desc = 'Decrease current window height' })
set('n', '<leader>ld', vim.diagnostic.setloclist, { desc = 'Open [d]iagnostic location list' })
set("x", "<leader>p", [["_dP]], { desc = 'Replace selected, mantain register' })
set({ 'n', 'v' }, "<leader>d", [["_d]], { desc = 'Delete selected, mantain register' })
set('n', "<leader>S", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Substitute word under cursor" })
set("n", "<leader>cn", "<cmd>cnext<CR>zz", { desc = 'Next quickfix list entry' })
set("n", "<leader>cp", "<cmd>cprev<CR>zz", { desc = 'Previous quickfix list entry' })
set("n", "<leader>ln", "<cmd>lnext<CR>zz", { desc = 'Next location list' })
set("n", "<leader>lp", "<cmd>lprev<CR>zz", { desc = 'Previous location list' })
set("i", "<C-U>", "<nop>", { desc = 'To avoid when C-Y' })
set('', '<F1>', '<Nop>', { noremap = true, silent = true })
set({ 'n', 'v', 'i' }, "<C-C>", "<CMD>cclose<CR>", { desc = "Close quickfix" })
if vim.fn.executable("lazygit") == 1 then
  set("n", "<leader>gg", function() Snacks.lazygit.open() end, { desc = "Lazygit" })
  set("n", "<leader>gf", function() Snacks.lazygit.log_file() end, { desc = "Lazygit (log current file)" })
  set("n", "<leader>gl", function() Snacks.lazygit.log_file() end, { desc = "Lazygit (log)" })
end
set("n", "<leader><leader>", ":", { desc = 'Commmand-line mode' })
set('n', '<leader>cf', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  print("Copied: " .. path)
end, { desc = "Copy full file path" })
set('v', '<leader>cf', function()
  local path = vim.fn.expand('%:p')
  local start_line = vim.fn.line('v')
  local end_line = vim.fn.line('.')
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  local result = start_line == end_line
    and path .. ':' .. start_line
    or path .. ':' .. start_line .. '-' .. end_line
  vim.fn.setreg('+', result)
  print("Copied: " .. result)
end, { desc = "Copy full file path with line range" })
