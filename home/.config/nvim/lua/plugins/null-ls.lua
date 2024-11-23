-- [nfnl] Compiled from fnl/plugins/null-ls.fnl by https://github.com/Olical/nfnl, do not edit.
local function mypy_opts(null_ls)
  local function _1_(params)
    return {"--hide-error-codes", "--hide-error-context", "--no-color-output", "--show-absolute-path", "--show-column-numbers", "--show-error-codes", "--no-error-summary", "--no-pretty", "--enable-incomplete-feature=NewGenericSyntax", params.temp_path}
  end
  local function _2_(line, params)
    return null_ls.builtins.diagnostics.mypy._opts.on_output(line:gsub(params.temp_path:gsub("([^%w])", "%%%1"), params.bufname), params)
  end
  return {args = _1_, on_output = _2_}
end
local function _3_()
  local null_ls = require("null-ls")
  local eslint_diagnostics = require("none-ls.diagnostics.eslint")
  return null_ls.setup({sources = {null_ls.builtins.diagnostics.mypy.with(mypy_opts(null_ls)), null_ls.builtins.formatting.black, eslint_diagnostics.with({diagnostic_config = {signs = false, virtual_text = false}}), require("none-ls.formatting.eslint"), require("none-ls.code_actions.eslint")}})
end
return {{"nvimtools/none-ls.nvim", dependencies = {"williamboman/mason.nvim", "nvimtools/none-ls-extras.nvim"}, ft = {"python", "typescript", "typescriptreact"}, config = _3_}}
