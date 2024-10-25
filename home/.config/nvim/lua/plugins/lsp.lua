-- [nfnl] Compiled from fnl/plugins/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
local cmp_srcs = {{name = "nvim_lsp"}, {name = "conjure"}, {name = "buffer"}, {name = "luasnip"}, {name = "path"}}
local function optimize_imports()
  local params = {command = "_typescript.organizeImports", arguments = {vim.api.nvim_buf_get_name(0)}, title = ""}
  return vim.lsp.buf.execute_command(params)
end
local function _1_()
  local cmp = require("cmp")
  local cmp_lsp = require("cmp_nvim_lsp")
  local cmp_ap = require("nvim-autopairs.completion.cmp")
  local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())
  local fidget = require("fidget")
  local cmp_select = {behavior = cmp.SelectBehavior.Select}
  local lspconfig = require("lspconfig")
  local luasnip = require("luasnip")
  local lspkind = require("lspkind")
  local handlers = {["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {severity_sort = true, update_in_insert = true, underline = true, signs = false, virtual_text = false}), ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single"}), ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})}
  local before_init
  local function _2_(params)
    params.workDoneToken = "1"
    return nil
  end
  before_init = _2_
  local on_attach
  local function _3_(_, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ld", "<Cmd>lua vim.lsp.buf.declaration()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<D-6>", "<cmd>lua vim.diagnostic.setloclist()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "i", "<D-6>", "<cmd>lua vim.diagnostic.setloclist()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>le", "<cmd>lua vim.diagnostic.open_float()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<F2>", "<cmd>lua vim.diagnostic.goto_next()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<S-F2>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-D-o>", ":lua require('telescope.builtin').lsp_document_symbols()<cr>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-M-D-o>", ":lua require('telescope.builtin').lsp_workspace_symbols()<cr>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-cr>", "<cmd>lua vim.lsp.buf.code_action()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "i", "<M-cr>", "<cmd>lua vim.lsp.buf.code_action()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "v", "<M-cr>", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lw", ":lua require('telescope.builtin').diagnostics()<cr>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<D-b>", ":lua require('telescope.builtin').lsp_references()<cr>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "i", "<D-b>", ":lua require('telescope.builtin').lsp_references()<cr>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-D-b>", ":lua require('telescope.builtin').lsp_implementations()<cr>", {noremap = true})
    return vim.api.nvim_buf_set_keymap(bufnr, "i", "<M-D-b>", ":lua require('telescope.builtin').lsp_implementations()<cr>", {noremap = true})
  end
  on_attach = _3_
  fidget.setup({notification = {window = {winblend = 0}}})
  lspconfig.clojure_lsp.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities})
  lspconfig.pyright.setup({capabilities = capabilities, before_init = before_init, on_attach = on_attach, handlers = handlers})
  lspconfig.fennel_ls.setup({capabilities = capabilities, before_init = before_init, on_attach = on_attach, handlers = handlers})
  lspconfig.lua_ls.setup({capabilities = capabilities, before_init = before_init, on_attach = on_attach, handlers = handlers})
  lspconfig.ts_ls.setup({capabilities = capabilities, before_init = before_init, on_attach = on_attach, handlers = handlers, commands = {OptimizeImports = {optimize_imports, description = "Optimize Imports"}}})
  cmp.event:on("confirm_done", cmp_ap.on_confirm_done())
  cmp.setup.cmdline({"/", "?"}, {mapping = cmp.mapping.preset.cmdline(), sources = {{name = "buffer"}}})
  cmp.setup.cmdline(":", {mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}}), matching = {disallow_symbol_nonprefix_matching = false}})
  local function _4_(args)
    return luasnip.lsp_expand(args.body)
  end
  local function _5_(fallback)
    if cmp.visible() then
      return cmp.select_next_item(cmp_select)
    elseif "else" then
      return fallback()
    else
      return nil
    end
  end
  local function _7_(fallback)
    if cmp.visible() then
      return cmp.select_prev_item(cmp_select)
    elseif "else" then
      return fallback()
    else
      return nil
    end
  end
  return cmp.setup({formatting = {format = lspkind.cmp_format({mode = "symbol_text", maxwidth = {menu = 50, abbr = 50}, ellipsis_char = "...", show_labelDetails = true})}, snippet = {expand = _4_}, mapping = cmp.mapping.preset.insert({["<C-b>"] = cmp.mapping.scroll_docs(( - 4)), ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<C-Space>"] = cmp.mapping.complete(), ["<CR>"] = cmp.mapping.confirm(), ["<Tab>"] = cmp.mapping(_5_, {"i", "s"}), ["<S-Tab>"] = cmp.mapping(_7_, {"i", "s"})}), sources = cmp.config.sources(cmp_srcs)})
end
return {{"SmiteshP/nvim-navic", lazy = true, config = true, opts = {lsp = {auto_attach = true, preference = {"pyright", "null-ls"}}, highlight = true, separator = "\239\145\160 ", click = true}, dependencies = {"neovim/nvim-lspconfig"}, enabled = false}, {"neovim/nvim-lspconfig", dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "hrsh7th/nvim-cmp", "LuaSnip", "saadparwaiz1/cmp_luasnip", "j-hui/fidget.nvim", "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "williamboman/mason.nvim", "onsails/lspkind.nvim"}, config = _1_}}
