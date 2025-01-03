return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    require('telescope').setup {
      pickers = {
        find_files = {
          theme = "ivy"
        }
      }
    }

    require('telescope').load_extension('fzf')

    local builtin = require 'telescope.builtin'
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = 'Telescope: help tags' })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = 'Telescope: find files' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Telescope: [S]earch [K]eymaps' })
    vim.keymap.set("n", "<leader>sn", function()
        require('telescope.builtin').find_files({
          cwd = vim.fn.stdpath("config")
        })
      end,
      { desc = 'Telescope: nvim config' })
    vim.keymap.set("n", "<leader>sp", function()
        require('telescope.builtin').find_files({
          cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
        })
      end,
      { desc = 'Telescope: lazy plugins' })
    require "config.telescope.multigrep".setup()
  end
}
