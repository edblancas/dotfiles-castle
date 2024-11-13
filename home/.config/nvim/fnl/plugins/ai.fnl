[{1 :supermaven-inc/supermaven-nvim
  :config (fn []
            (let [sm (require :supermaven-nvim)]
              (sm.setup {:keymaps {:acept_word :<C-S-j>}
                         :ignore_filetypes [:cpp]})))}]
