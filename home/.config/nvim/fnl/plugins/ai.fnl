[{1 :supermaven-inc/supermaven-nvim
  :config (fn []
            (let [sm (require :supermaven-nvim)]
              (sm.setup {:keymaps {:accept_suggestion "<C-CR>"
                                   :accept_word "<C-S-j>"
                                   :clear_suggestion "<C-BS>"
                         :ignore_filetypes [:python]}})))}]
