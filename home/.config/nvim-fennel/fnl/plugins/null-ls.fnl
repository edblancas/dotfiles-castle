;see issue https://github.com/nvimtools/none-ls.nvim/issues/97
(fn mypy-opts [null_ls] {:args (fn [params]
                                  ["--hide-error-codes"
                                   "--hide-error-context"
                                   "--no-color-output"
                                   "--show-absolute-path"
                                   "--show-column-numbers"
                                   "--show-error-codes"
                                   "--no-error-summary"
                                   "--no-pretty"
                                   ;PEP 695 generics are not yet supported
                                   "--enable-incomplete-feature=NewGenericSyntax"
                                   params.temp_path])
                          :on_output (fn [line params]
                                       (-> (line:gsub (params.temp_path:gsub "([^%w])" "%%%1") params.bufname)
                                           (null_ls.builtins.diagnostics.mypy._opts.on_output params)))})

[{1 :nvimtools/none-ls.nvim
  :dependencies [:williamboman/mason.nvim :nvimtools/none-ls-extras.nvim]
  :ft [:python :typescript :typescriptreact]
  :config (fn []
            (let [null_ls (require :null-ls)
                  eslint-diagnostics (require :none-ls.diagnostics.eslint)]
              (null_ls.setup {:sources [(null_ls.builtins.diagnostics.mypy.with (mypy-opts null_ls))
                                        null_ls.builtins.formatting.black
                                        ;(eslint-diagnostics.with {:diagnostic_config {:signs false :virtual_text false}})
                                        (require :none-ls.formatting.eslint)
                                        (require :none-ls.code_actions.eslint)]})))}]

