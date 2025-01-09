return {
  {
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require('copilot').setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<C-M-y>",
            accept_word = "<C-f>",
            accept_line = "<C-M-f>",
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
