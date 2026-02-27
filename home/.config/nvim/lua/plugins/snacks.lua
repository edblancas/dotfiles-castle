return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      lazygit = { enabled = true },
      explorer = { enabled = true },
    },
    config = function(_, opts)
      require("snacks").setup(opts)
      local root = require("root")

      vim.keymap.set("n", "<leader>fe", function()
        require("snacks").explorer({ cwd = root.get() })
      end, { desc = "Explorer (root)" })

      vim.keymap.set("n", "<leader>fE", function()
        require("snacks").explorer()
      end, { desc = "Explorer (cwd)" })
    end,
  }
}
