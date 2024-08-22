[ {1 :mfussenegger/nvim-dap
  :config (fn []
            (vim.keymap.set [:n :i] "<D-F8>" "<cmd>DapToggleBreakpoint<cr>" {:desc "Toggle Breakpoint"})
            (vim.keymap.set [:n :i] "<F7>" "<cmd>DapStepInto<cr>" {:desc "Debug Step Into"})
            (vim.keymap.set [:n :i] "<F8>" "<cmd>DapStepOver<cr>" {:desc "Debug Step Over"})
            (vim.keymap.set [:n :i] "<S-F8>" "<cmd>DapStepOut<cr>" {:desc "Debug Step Out"})
            (vim.keymap.set [:n :i] "<F9>" "<cmd>DapContinue<cr>" {:desc "Debug Continue"})
            (vim.keymap.set [:n :i] "<D-F2>" "<cmd>DapTerminate<cr>" {:desc "Debug Terminate"}))}

 {1 :rcarriga/nvim-dap-ui
  :version "v4.*"
  :dependencies [:mfussenegger/nvim-dap :nvim-neotest/nvim-nio]
  :keys [{1 "<localleader>du" 2 (fn [] (let [dapui (require :dapui)] (dapui.toggle))) :desc "Toggle Debug UI"}
         {1 "<localleader>dr" 2 (fn [] (let [dapui (require :dapui)] (dapui.open {:reset true}))) :desc "Reset Windows Debug UI"}]
  :config (fn []
            (let [dap (require :dap)
                  dapui (require :dapui)]
              (dapui.setup)
              (tset dap.listeners.before.attach :dapui_config (fn [] (dapui.open)))
              (tset dap.listeners.before.launch :dapui_config (fn [] (dapui.open)))
              (tset dap.listeners.before.event_terminated :dapui_config (fn [] (dapui.close)))
              (tset dap.listeners.before.event_exited :dapui_config (fn [] (dapui.close)))))}

 {1 :mfussenegger/nvim-dap-python
 :ft :python
 :dependencies [:mfussenegger/nvim-dap :rcarriga/nvim-dap-ui]
 :config (fn []
           (let [dap-python (require :dap-python)]
             (dap-python.setup "/Users/dan/.local/pipx/venvs/debugpy/bin/python")
             (vim.keymap.set [:n :i] "<C-M-d>" ":lua require('dap-python').test_method()<CR>" {:desc "Debug Python method" :noremap true})
             (vim.keymap.set [:n :i] "<localleader>dc" ":lua require('dap-python').test_class()<CR>" {:desc "Debug Python class" :noremap true})
             (vim.keymap.set [:v] "<C-M-d>" "<ESC>:lua require('dap-python').debug_selection()<CR>" {:desc "Debug Python selection" :noremap true})))}]

