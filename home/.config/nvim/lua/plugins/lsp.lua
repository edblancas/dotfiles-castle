-- [nfnl] Compiled from fnl/plugins/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
local cmp_srcs = {{name = "nvim_lsp"}, {name = "conjure"}, {name = "buffer"}, {name = "luasnip"}}
local icons = {File = "\238\169\187 ", Module = "\238\170\139 ", Namespace = "\238\170\139 ", Package = "\238\172\169 ", Class = "\238\173\155 ", Method = "\238\170\140 ", Property = "\238\173\165 ", Field = "\238\173\159 ", Constructor = "\238\170\140 ", Enum = "\238\170\149 ", Interface = "\238\173\161 ", Function = "\238\170\140 ", Variable = "\238\170\136 ", Constant = "\238\173\157 ", String = "\238\174\141 ", Number = "\238\170\144 ", Boolean = "\238\170\143 ", Array = "\238\170\138 ", Object = "\238\170\139 ", Key = "\238\170\147 ", Null = "\238\170\143 ", EnumMember = "\238\173\158 ", Struct = "\238\170\145 ", Event = "\238\170\134 ", Operator = "\238\173\164 ", Text = "\238\170\145", Snippet = "\238\173\166", Keyword = "\238\173\162", Reference = "\238\170\148", TypeParameter = "\238\170\146 "}
local function kind__3eicon(kind)
  local icon
  do
    local t_1_ = icons
    if (nil ~= t_1_) then
      t_1_ = t_1_[kind]
    else
    end
    icon = t_1_
  end
  if (icon == nil) then
    return ""
  else
    return icon
  end
end
local function optimize_imports()
  local params = {command = "_typescript.organizeImports", arguments = {vim.api.nvim_buf_get_name(0)}, title = ""}
  return vim.lsp.buf.execute_command(params)
end
local function _4_()
  local cmp = require("cmp")
  local cmp_lsp = require("cmp_nvim_lsp")
  local cmp_ap = require("nvim-autopairs.completion.cmp")
  local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())
  local fidget = require("fidget")
  local cmp_select = {behavior = cmp.SelectBehavior.Select}
  local lspconfig = require("lspconfig")
  local luasnip = require("luasnip")
  local handlers = {["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {severity_sort = true, update_in_insert = true, underline = true, signs = false, virtual_text = false}), ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single"}), ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})}
  local before_init
  local function _5_(params)
    params.workDoneToken = "1"
    return nil
  end
  before_init = _5_
  local on_attach
  local function _6_(_, bufnr)
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
    vim.api.nvim_buf_set_keymap(bufnr, "v", "<M-cr>", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lw", ":lua require('telescope.builtin').diagnostics()<cr>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<D-b>", ":lua require('telescope.builtin').lsp_references()<cr>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "i", "<D-b>", ":lua require('telescope.builtin').lsp_references()<cr>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-D-b>", ":lua require('telescope.builtin').lsp_implementations()<cr>", {noremap = true})
    return vim.api.nvim_buf_set_keymap(bufnr, "i", "<M-D-b>", ":lua require('telescope.builtin').lsp_implementations()<cr>", {noremap = true})
  end
  on_attach = _6_
  fidget.setup({})
  lspconfig.clojure_lsp.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities})
  lspconfig.pyright.setup({capabilities = capabilities, before_init = before_init, on_attach = on_attach, handlers = handlers})
  lspconfig.fennel_ls.setup({capabilities = capabilities, before_init = before_init, on_attach = on_attach, handlers = handlers})
  lspconfig.lua_ls.setup({capabilities = capabilities, before_init = before_init, on_attach = on_attach, handlers = handlers})
  lspconfig.ts_ls.setup({capabilities = capabilities, before_init = before_init, on_attach = on_attach, handlers = handlers, commands = {OptimizeImports = {optimize_imports, description = "Optimize Imports"}}})
  cmp.event:on("confirm_done", cmp_ap.on_confirm_done())
  cmp.setup.cmdline({"/", "?"}, {mapping = cmp.mapping.preset.cmdline(), sources = {{name = "buffer"}}})
  cmp.setup.cmdline(":", {mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}}), matching = {disallow_symbol_nonprefix_matching = false}})
  local function _7_(_, vim_item)
    vim_item["kind"] = (kind__3eicon(vim_item.kind) .. " " .. vim_item.kind)
    return vim_item
  end
  local function _8_(args)
    return luasnip.lsp_expand(args.body)
  end
  local function _9_(fallback)
    if cmp.visible() then
      return cmp.select_next_item(cmp_select)
    elseif "else" then
      return fallback()
    else
      return nil
    end
  end
  local function _11_(fallback)
    if cmp.visible() then
      return cmp.select_prev_item(cmp_select)
    elseif "else" then
      return fallback()
    else
      return nil
    end
  end
  return cmp.setup({formatting = {format = _7_}, snippet = {expand = _8_}, mapping = cmp.mapping.preset.insert({["<C-b>"] = cmp.mapping.scroll_docs(( - 4)), ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<C-Space>"] = cmp.mapping.complete(), ["<CR>"] = cmp.mapping.confirm(), ["<Tab>"] = cmp.mapping(_9_, {"i", "s"}), ["<S-Tab>"] = cmp.mapping(_11_, {"i", "s"})}), sources = cmp.config.sources(cmp_srcs)})
end
return {{"SmiteshP/nvim-navic", config = true, opts = {lsp = {auto_attach = true, preference = {"pyright", "null-ls"}}, highlight = true, separator = "\239\145\160 ", click = true, icons = icons}, dependencies = {"neovim/nvim-lspconfig"}}, {"neovim/nvim-lspconfig", dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip", "j-hui/fidget.nvim", "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "williamboman/mason.nvim"}, config = _4_}}
