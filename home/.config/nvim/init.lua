require("config.lazy")

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  desc = "Automatically check for file changes in normal mode",
  command = "checktime"
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function()
    vim.api.nvim_echo({ { "File changed on disk. Buffer reloaded.", "WarningMsg" } }, false, {})
  end,
})
