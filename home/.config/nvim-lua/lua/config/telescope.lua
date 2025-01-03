local data = assert(vim.fn.stdpath "data") --[[@as string]]

require('telescope').setup {
  pickers = {
    find_files = {
      theme = "ivy"
    }
  },
  extensions = {
    wrap_results = true,

    fzf = {},
    history = {
      path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
      limit = 100,
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  },
}

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require 'telescope.builtin'
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = 'Telescope: help tags' })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = 'Telescope: find files' })
vim.keymap.set("n", "<space>sd", function()
    return builtin.git_files { cwd = vim.fn.expand "%:h" }
  end,
  { desc = 'Telescope: git_files' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Telescope: keymaps' })
vim.keymap.set("n", "<space>sb", builtin.buffers, { desc = 'Telescope: buffers' })
vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find, { desc = 'Telescope: current buffer fuzzy find' })
vim.keymap.set("n", "<leader>sn", function()
    require('telescope.builtin').find_files({
      cwd = vim.fn.stdpath("config")
    })
  end,
  { desc = 'Telescope: nvim config' })
vim.keymap.set("n", "<leader>sp", function()
    require('telescope.builtin').find_files({
      ---@diagnostic disable-next-line: param-type-mismatch
      cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
    })
  end,
  { desc = 'Telescope: lazy plugins' })
vim.keymap.set("n", "<leader>sg", require "config.telescope.multigrep", { desc = 'Telescope: live multigrep' })
