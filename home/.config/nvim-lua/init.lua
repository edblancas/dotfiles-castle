require("config.lazy")

vim.opt.shiftwidth = 2
vim.opt.clipboard = "unnamed"
vim.opt.timeoutlen = 300

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

vim.keymap.set({ "t" }, "<esc><esc>", "<c-\\><c-n>")
local job_id = -1
local term_buf = -1
vim.keymap.set("n", "<space>st", function()
  if (job_id and vim.api.nvim_buf_is_valid(term_buf)) then
    local term_win = vim.fn.bufwinid(term_buf)
    if (term_win >= 0) then
      return vim.api.nvim_win_close(term_win, true)
    else
      vim.cmd.new()
      vim.cmd.wincmd("J")
      vim.cmd.buffer(term_buf)
      return vim.api.nvim_win_set_height(0, 15)
    end
  else
    vim.cmd.new()
    vim.cmd.wincmd("J")
    vim.cmd.term()
    vim.cmd.set("nonumber")
    vim.cmd.set("norelativenumber")
    vim.api.nvim_win_set_height(0, 15)
    term_buf = vim.api.nvim_get_current_buf()
    job_id = vim.bo.channel
    return nil
  end
end)

vim.keymap.set({ "n" }, "<leader>mt", function()
  vim.fn.chansend(job_id, { "make test\13\n" })
end, { desc = "make test" })
