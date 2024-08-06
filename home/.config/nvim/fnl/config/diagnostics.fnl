(local conf {:settings
              {:all false
               :start_on false
               :underline {:default false}
               :virtual_text {:default false}
               :signs {:default false}
               :update_in_insert {:default false}}})

(fn turn-off-diagnostics-buffer []
  (tset vim.lsp.handlers "textDocument/publishDiagnostics" (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics conf.settings))
  (let [clients (vim.lsp.get_active_clients)
        show-fn (fn [b c conf] 
                  (each [ns _ (pairs (vim.diagnostic.get_namespaces))]
                    (vim.diagnostic.show ns b nil conf)))]
    (each [client_id _ (pairs clients)]
      (let [buffers (vim.lsp.get_buffers_by_client_id client_id)]
        (each [_ buffer_id (ipairs buffers)]
          (show-fn buffer_id client_id conf.settings))))))

(comment 
  (vim.lsp.get_active_clients)
  (each [_ buffer_id (ipairs (vim.lsp.get_buffers_by_client_id 1))]
            (print buffer_id conf.settings))
  (print conf.settings)
  (print (. conf :settings)) 
  (vim.diagnostic.get_namespaces)
  (vim.diagnostic.show 34 1 nil conf.settings)
  (vim.notify "hello!!!" vim.log.levels.INFO)

  ; display fn not exists
  (let [lsp-diagnostic (require :vim.lsp.diagnostic)]
    (lsp-diagnostic.display nil 1 1 conf.settings))

  (print (vim.inspect vim))
  (vim.diagnostic.hide 34 1) ;; this is the one
  )

{: turn-off-diagnostics-buffer
 :t (fn [] (print "works!!!"))}
