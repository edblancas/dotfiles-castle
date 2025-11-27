require('telescope').setup {
  pickers = {
    find_files = {
      theme = "ivy"
    }
  },
  extensions = {
    wrap_results = true,
    fzf = {},
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  },
}

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require 'telescope.builtin'
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = 'Telescope: help tags' })
vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = 'Telescope: find files' })
vim.keymap.set("n", "<space>ff", function()
    return builtin.git_files { cwd = vim.fn.expand "%:h" }
  end,
  { desc = 'Telescope: git_files' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope: keymaps' })
vim.keymap.set("n", "<space>fb", builtin.buffers, { desc = 'Telescope: buffers' })
vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find, { desc = 'Telescope: current buffer fuzzy find' })
vim.keymap.set("n", "<leader>fn", function()
    require('telescope.builtin').find_files({
      cwd = vim.fn.stdpath("config")
    })
  end,
  { desc = 'Telescope: nvim config' })
vim.keymap.set("n", "<leader>fp", function()
    require('telescope.builtin').find_files({
      ---@diagnostic disable-next-line: param-type-mismatch
      cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
    })
  end,
  { desc = 'Telescope: lazy plugins' })
vim.keymap.set("n", "<leader>fg", require "config.telescope.multigrep", { desc = 'Telescope: live multigrep' })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = 'Telescope: diagnostics' })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = 'Telescope: doc symbols' })
vim.keymap.set("n", "<leader>fw", builtin.lsp_workspace_symbols, { desc = 'Telescope: workspace symbols' })
vim.keymap.set("n", "<leader>fc", function()
  require("telescope.builtin").find_files({
    cwd = vim.fn.expand("$HOME/.homesick/repos/dotfiles-castle"),
    hidden = true,      -- show dotfiles
    no_ignore = true,   -- do not ignore files from .gitignore, etc.
    follow = true,      -- follow symlinks (common in dotfiles)
  })
end, { desc = "Telescope: dotfiles castle" })
vim.keymap.set("n", "<leader>fC", function()
  require("telescope.builtin").live_grep({
    cwd = vim.fn.expand("$HOME/.homesick/repos/dotfiles-castle"),
    hidden = true,
  })
end, { desc = "Telescope: grep dotfiles castle" })
