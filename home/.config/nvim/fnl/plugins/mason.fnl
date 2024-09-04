;mypy: type hints python
;black: format file python
;ruff: lint/diagnostics python, deprecated by none-ls?
;https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins
[{1 :williamboman/mason.nvim
  :opts {:ensure_installed [:mypy :black]}
  :config true}
;pyright: lsp autocomplete python
 {1 :williamboman/mason-lspconfig.nvim
  :config true
  :opts {:ensure_installed [:pyright]}
  :dependencies [:williamboman/mason.nvim]}]
