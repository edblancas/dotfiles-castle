;mypy: type hints python
;black: format file python
;ruff: lint/diagnostics python, deprecated by none-ls?
;prettier: format typescript .prettierrc
;https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins
[{1 :williamboman/mason.nvim
  :opts {:ensure_installed [:mypy :black :prettierd :eslint_d]}
  :config true}
;pyright: lsp autocomplete python
 {1 :williamboman/mason-lspconfig.nvim
  :config true
  :enabled false
  :opts {:ensure_installed [:pyright :ts_ls]}
  :dependencies [:williamboman/mason.nvim]}]
