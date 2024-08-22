[{1 :rcarriga/nvim-dap-ui
  :dependencies [:mfussenegger/nvim-dap :nvim-neotest/nvim-nio]
  :config (fn []
    (let [dap (require :dap)
          dapui (require :dapui)]
      (dapui.setup)
      (tset dap.listeners.before.attach :dapui_config (fn [] (dapui.open)))
      (tset dap.listeners.before.launch :dapui_config (fn [] (dapui.open)))
      (tset dap.listeners.before.event_terminated :dapui_config (fn [] (dapui.close)))
      (tset dap.listeners.before.event_exited :dapui_config (fn [] (dapui.close)))))}
 {1 :mfussenegger/nvim-dap
  :config (fn []
            (vim.keymap.set [:n :i] "<F8>" "<cmd>DapToggleBreakpoint<cr>" {:desc "Toggle Breakpoint"}))}
 {1 :mfussenegger/nvim-dap-python
 :ft :python
 :dependencies [:mfussenegger/nvim-dap :mfussenegger/nvim-dap-ui]
 :config (fn []
           (let [dap-python (require :dap-python)]
             (dap-python.setup "/Users/dan/.local/pipx/venvs/debugpy/bin/python")
             (vim.keymap.set [:n :i] "<C-M-d>" ":lua require('dap-python').test_method()<CR>" {:desc "Debug Python method" :noremap true})
             (vim.keymap.set [:n :i] "<localleader>dc" ":lua require('dap-python').test_class()<CR>" {:desc "Debug Python class" :noremap true})
             (vim.keymap.set [:v] "<C-M-d>" "<ESC>:lua require('dap-python').debug_selection()<CR>" {:desc "Debug Python selection" :noremap true})))}]

