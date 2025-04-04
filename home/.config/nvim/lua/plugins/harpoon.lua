return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      local extensions = require("harpoon.extensions");

      harpoon:setup()
      harpoon:extend(extensions.builtins.navigate_with_number());

      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = 'Harpoon: add' })
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end)
      vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end)
    end
  }
}
