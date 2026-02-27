return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "classic",
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
          desc = "Find/Picker",
          icon = { icon = " ", color = "blue" },
          mode = { "n" }
        },
        {
          "<leader>g",
          desc = "Git",
          icon = { icon = " ", color = "orange" },
          mode = { "n" }
        },
        {
          "<leader>s",
          desc = "Search",
          icon = { icon = " ", color = "green" },
          mode = { "n", "x" }
        },
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
