return {
  {
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require('copilot').setup({
        panel = {
          keymap = {
            refresh = "grc"
          },
        },
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept_word = "<C-f>",
            accept_line = "<C-M-f>",
          },
        },
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
