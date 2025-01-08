return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        {
          "<leader>v",
          desc = "Vimux",
          icon = { cat = "filetype", name = "tmux" },
          mode = { "n" }
        },
        {
          "<leader>h",
          desc = "Harpoon",
          icon = { cat = "filetype", name = "harpoon" },
          mode = { "n" }
        },
        {
          "<leader>f",
          desc = "Telescope",
          icon = { cat = "filetype", name = "telescopeprompt" },
          mode = { "n" }
        }
      }
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
