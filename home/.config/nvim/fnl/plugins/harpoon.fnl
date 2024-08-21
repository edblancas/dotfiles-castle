[{1 :ThePrimeagen/harpoon
  :branch :harpoon2
  :dependencies ["nvim-lua/plenary.nvim"]
  :config (fn []
    (let [h (require :harpoon)
          lst (h:list)]
      (h:setup)
      (vim.keymap.set "n" "<leader>ba" (fn [] (lst:add)))
      (vim.keymap.set "n" "<C-e>" (fn [] (h.ui:toggle_quick_menu (h:list))))

      (vim.keymap.set "n" "<M-D-1>" (fn [] (lst:select 1)))
      (vim.keymap.set "n" "<M-D-2>" (fn [] (lst:select 2)))
      (vim.keymap.set "n" "<M-D-3>" (fn [] (lst:select 3)))
      (vim.keymap.set "n" "<M-D-4>" (fn [] (lst:select 4)))

      ;Toggle previous & next buffers stored within Harpoon list
      (vim.keymap.set "n" "<leader>bp" (fn [] (lst:prev)))
      (vim.keymap.set "n" "<leader>bn" (fn [] (lst:next)))))}]
