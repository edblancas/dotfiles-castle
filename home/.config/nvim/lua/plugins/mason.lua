-- [nfnl] Compiled from fnl/plugins/mason.fnl by https://github.com/Olical/nfnl, do not edit.
return {{"williamboman/mason.nvim", opts = {ensure_installed = {"mypy", "black", "prettierd", "eslint_d"}}, config = true}, {"williamboman/mason-lspconfig.nvim", config = true, opts = {ensure_installed = {"pyright", "ts_ls"}}, dependencies = {"williamboman/mason.nvim"}, enabled = false}}
