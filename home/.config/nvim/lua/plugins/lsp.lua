-- [nfnl] Compiled from fnl/plugins/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local cmp = require("cmp")
  local cmp_lsp = require("cmp_nvim_lsp")
  local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())
  local fidget = require("fidget")
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local cmp_select = {behavior = cmp.SelectBehavior.Select}
  local lspconfig = require("lspconfig")
  local lspconfig_util = require("lspconfig.util")
  fidget.setup({})
  mason.setup({})
  local function _2_(server_name)
    local lspconfig_server = require("lspconfig")[server_name]
    return lspconfig_server.setup({capabilities = capabilities})
  end
  mason_lspconfig.setup({ensure_installed = {"pylsp"}, handlers = {_2_}})
  lspconfig.fennel_ls.setup({root_dir = lspconfig_util.root_pattern("flsproject.fnl")})
  local function _3_(args)
    local luasnip = requiere("luasnip")
    return luasnip.lsp_expand(args.body)
  end
  return cmp.setup({snippet = {expand = _3_}, mapping = cmp.mapping.preset.insert({["<C-p>"] = cmp.mapping.select_prev_item(cmp_select), ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select), ["<C-n>"] = cmp.mapping.select_next_item(cmp_select), ["<Tab>"] = cmp.mapping.select_next_item(cmp_select), ["<CR>"] = cmp.mapping.confirm({select = true}), ["<C-Space>"] = cmp.mapping.complete()}), sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "luasnip"}}, {{name = "buffer"}})})
end
return {{"neovim/nvim-lspconfig", dependencies = {"williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip", "j-hui/fidget.nvim"}, config = _1_}}
