(local cmp-srcs
  [{:name :nvim_lsp}
   {:name :conjure}
   {:name :buffer}
   {:name :luasnip}])

(fn kind->icon [kind]
  ;https://github.com/mortepau/codicons.nvim/blob/master/lua/codicons/table.lua
  (let [icons {:Variable ""
               :Function ""
               :Class ""
               :Text ""
               :Keyword ""
               :Snippet ""
               :Module ""
               :Reference ""
               :Method ""
               :Constant ""
               :Property ""}
        icon (?. icons kind)]
    (if (= icon nil)
        ""
        icon)))

[{1 :neovim/nvim-lspconfig
    :dependencies [
        :hrsh7th/cmp-nvim-lsp
        :hrsh7th/cmp-buffer
        :hrsh7th/cmp-path
        :hrsh7th/cmp-cmdline
        :hrsh7th/nvim-cmp
        :L3MON4D3/LuaSnip
        :saadparwaiz1/cmp_luasnip
        :j-hui/fidget.nvim

        :williamboman/mason.nvim
        :williamboman/mason-lspconfig.nvim
        :williamboman/mason.nvim]
    :config (fn []
              (let [cmp (require :cmp)
                    cmp_lsp (require :cmp_nvim_lsp)
                    cmp-ap (require :nvim-autopairs.completion.cmp)
                    capabilities (vim.tbl_deep_extend :force
                                                      {}
                                                      (vim.lsp.protocol.make_client_capabilities)
                                                      (cmp_lsp.default_capabilities))
                    fidget (require :fidget)
                    cmp_select {:behavior cmp.SelectBehavior.Select}
                    lspconfig (require :lspconfig)
                    luasnip (require :luasnip)
                    handlers {"textDocument/publishDiagnostics"
                           (vim.lsp.with
                             vim.lsp.diagnostic.on_publish_diagnostics
                             {:severity_sort true
                              :update_in_insert true
                              :signs false
                              :underline true
                              :virtual_text false})
                           "textDocument/hover"
                           (vim.lsp.with
                             vim.lsp.handlers.hover
                             {:border "single"})
                           "textDocument/signatureHelp"
                           (vim.lsp.with
                             vim.lsp.handlers.signature_help
                             {:border "single"})}
                    before_init (fn [params]
                                (set params.workDoneToken :1))
                    on_attach (fn [_ bufnr]
                             (do
                               (vim.api.nvim_buf_set_keymap bufnr :n :gd "<Cmd>lua vim.lsp.buf.definition()<CR>" {:noremap true})
                               (vim.api.nvim_buf_set_keymap bufnr :n :<leader>ld "<Cmd>lua vim.lsp.buf.declaration()<CR>" {:noremap true})
                               (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lt "<cmd>lua vim.lsp.buf.type_definition()<CR>" {:noremap true})
                               (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lh "<cmd>lua vim.lsp.buf.signature_help()<CR>" {:noremap true})
                               (vim.api.nvim_buf_set_keymap bufnr :n :<leader>ln "<cmd>lua vim.lsp.buf.rename()<CR>" {:noremap true})
                               (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lq "<cmd>lua vim.diagnostic.setloclist()<CR>" {:noremap true})
                               (vim.api.nvim_buf_set_keymap bufnr :n :<leader>le "<cmd>lua vim.diagnostic.open_float()<CR>" {:noremap true})
                               (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lf "<cmd>lua vim.lsp.buf.format()<CR>" {:noremap true})

                               ;like idea
                               (vim.api.nvim_buf_set_keymap bufnr :n :<F2> "<cmd>lua vim.diagnostic.goto_next()<CR>" {:noremap true})
                               (vim.api.nvim_buf_set_keymap bufnr :n :<S-F2> "<cmd>lua vim.diagnostic.goto_prev()<CR>" {:noremap true})
                               (vim.api.nvim_buf_set_keymap bufnr :n :<M-D-o> ":lua require('telescope.builtin').lsp_document_symbols()<cr>" {:noremap true})
                               (vim.api.nvim_buf_set_keymap bufnr :n :<C-M-D-o> ":lua require('telescope.builtin').lsp_workspace_symbols()<cr>" {:noremap true})

                               (vim.api.nvim_buf_set_keymap bufnr :n :<leader>la "<cmd>lua vim.lsp.buf.code_action()<CR>" {:noremap true})
                               (vim.api.nvim_buf_set_keymap bufnr :v :<leader>la "<cmd>lua vim.lsp.buf.range_code_action()<CR>" {:noremap true})
                               ;telescope
                               (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lw ":lua require('telescope.builtin').diagnostics()<cr>" {:noremap true})
                               (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lr ":lua require('telescope.builtin').lsp_references()<cr>" {:noremap true})
                               (vim.api.nvim_buf_set_keymap bufnr :n :<leader>li ":lua require('telescope.builtin').lsp_implementations()<cr>" {:noremap true})))]

                (fidget.setup {})

                (lspconfig.clojure_lsp.setup {:on_attach on_attach
                                              :handlers handlers
                                              :before_init before_init
                                              :capabilities capabilities})

                (lspconfig.pyright.setup {:capabilities capabilities
                                          :before_init before_init
                                          :on_attach on_attach
                                          :handlers handlers})

                (lspconfig.fennel_ls.setup {:capabilities capabilities
                                            ;:root_dir (lspconfig-util.root_pattern "flsproject.fnl")
                                            :before_init before_init
                                            :on_attach on_attach
                                            :handlers handlers})

                (lspconfig.lua_ls.setup {:capabilities capabilities
                                         :before_init before_init
                                         :on_attach on_attach
                                         :handlers handlers})

                (lspconfig.tsserver.setup {:capabilities capabilities
                                           :before_init before_init
                                           :on_attach on_attach
                                           :handlers handlers})

                (cmp.event:on "confirm_done" (cmp-ap.on_confirm_done))

                ;Use buffer source for `/` and `?`
                (cmp.setup.cmdline ["/" "?"] {:mapping (cmp.mapping.preset.cmdline) 
                                              :sources [{:name "buffer"}]})
                ;Use cmdline & path source for ':'
                (cmp.setup.cmdline ":" {:mapping (cmp.mapping.preset.cmdline) 
                                        :sources (cmp.config.sources [{:name "path"}] [{:name "cmdline"}]) 
                                        :matching {:disallow_symbol_nonprefix_matching false}})

                (cmp.setup {:formatting {:format (fn [_ vim_item] 
                                                   (tset vim_item :kind (.. (kind->icon vim_item.kind) " " vim_item.kind)) 
                                                   vim_item)}
                            :snippet {:expand (fn [args]
                                                (luasnip.lsp_expand args.body))}
                            :mapping (cmp.mapping.preset.insert {:<C-b> (cmp.mapping.scroll_docs (- 4))
                                                                 :<C-f> (cmp.mapping.scroll_docs 4)
                                                                 "<C-Space>" (cmp.mapping.complete)
                                                                 :<CR> (cmp.mapping.confirm)
                                                                 :<Tab> (cmp.mapping (fn [fallback]
                                                                                       (if
                                                                                         (cmp.visible) (cmp.select_next_item cmp_select)
                                                                                         :else (fallback)))
                                                                                     {1 :i 2 :s})
                                                                 :<S-Tab> (cmp.mapping (fn [fallback]
                                                                                         (if
                                                                                           (cmp.visible) (cmp.select_prev_item cmp_select)
                                                                                           :else (fallback)))
                                                                                       {1 :i 2 :s})})
                            :sources (cmp.config.sources  cmp-srcs)})))}]
