return {
  {
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    event = "InsertEnter",
    enabled = true,
    config = function()
      require('copilot').setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<C-g>",
            accept_word = "<C-f>",
            accept_line = "<C-h>",
          },
          panel = {
            keymap = {
              refresh = "grc"
            },
          }
        }
      })
    end
  },
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = {
      signature = { enabled = true }
    }
  }
}
