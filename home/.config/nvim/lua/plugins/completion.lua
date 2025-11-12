return {
  {
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    event = "InsertEnter",
    enabled = false,
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
    version = '1.*',
    opts = {
      signature = { enabled = true },
      completion = {
        documentation = {
          auto_show = true,
        },
      },
    },
  }
}
