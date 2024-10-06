[{1 :ThePrimeagen/harpoon
  :branch :harpoon2
  :dependencies ["nvim-lua/plenary.nvim"]
  :config (fn []
    (let [h (require :harpoon)
          lst (h:list)]
      (h:setup)
      (vim.keymap.set :n "<leader>ha" (fn [] (lst:add) {:desc "Harpoon add"}))
      (vim.keymap.set [:n :i] "<C-e>" (fn [] (h.ui:toggle_quick_menu (h:list))))

      (vim.keymap.set [:n :i] "<M-D-1>" (fn [] (lst:select 1)))
      (vim.keymap.set [:n :i] "<M-D-2>" (fn [] (lst:select 2)))
      (vim.keymap.set [:n :i] "<M-D-3>" (fn [] (lst:select 3)))
      (vim.keymap.set [:n :i] "<M-D-4>" (fn [] (lst:select 4)))

      (vim.keymap.set :n "<leader><M-D-1>" (fn [] (lst:replace_at 1)))
      (vim.keymap.set :n "<leader><M-D-2>" (fn [] (lst:replace_at 2)))
      (vim.keymap.set :n "<leader><M-D-3>" (fn [] (lst:replace_at 3)))
      (vim.keymap.set :n "<leader><M-D-4>" (fn [] (lst:replace_at 4)))
                      
      ;Toggle previous & next buffers stored within Harpoon list
      (vim.keymap.set :n "<leader>hp" (fn [] (lst:prev)) {:desc "Harpoon previous"})
      (vim.keymap.set :n "<leader>hn" (fn [] (lst:next)) {:desc "Harpoon next"})))}]
