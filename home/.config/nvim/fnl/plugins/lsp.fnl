[{1 :neovim/nvim-lspconfig
    :dependencies [
        :williamboman/mason.nvim
        :williamboman/mason-lspconfig.nvim
        :hrsh7th/cmp-nvim-lsp
        :hrsh7th/cmp-buffer
        :hrsh7th/cmp-path
        :hrsh7th/cmp-cmdline
        :hrsh7th/nvim-cmp
        :L3MON4D3/LuaSnip
        :saadparwaiz1/cmp_luasnip
        :j-hui/fidget.nvim]
    :config (fn []
              (let [cmp (require :cmp)
                    cmp_lsp (require :cmp_nvim_lsp)
                    capabilities (vim.tbl_deep_extend :force
                                                      {}
                                                      (vim.lsp.protocol.make_client_capabilities)
                                                      (cmp_lsp.default_capabilities))
                    fidget (require :fidget)
                    mason (require :mason)
                    mason-lspconfig (require :mason-lspconfig)
                    cmp_select {:behavior cmp.SelectBehavior.Select}]
                (fidget.setup {})
                (mason.setup {})
                (mason-lspconfig.setup {:ensure_installed [:pyright]
                                        :handlers [(fn [server_name]
                                                     (let [lspconfig (require :lspconfig)
                                                           lspconfig-server (. lspconfig server_name)]
                                                       (lspconfig-server.setup {:capabilities capabilities})))]})
                (cmp.setup {:snippet {:expand (fn [args]
                                                (let [luasnip (requiere :luasnip)]
                                                  (luasnip.lsp_expand args.body)))}
                            :mapping (cmp.mapping.preset.insert {"<C-p>" (cmp.mapping.select_prev_item cmp_select)
                                                                 "<C-n>" (cmp.mapping.select_next_item cmp_select)
                                                                 "<CR>" (cmp.mapping.confirm {:select true})
                                                                 "<C-Space>" (cmp.mapping.complete)})
                            :sources (cmp.config.sources [{:name :nvim_lsp} {:name :luasnip}] [{:name :buffer}])})
                (vim.diagnostic.config {:float {:focusable false
                                                :style :minimal
                                                :border :rounded
                                                :source :always
                                                :header ""
                                                :prefix ""}})))}]
