local function organize_imports()
  vim.lsp.buf.code_action({
    context = { only = { "source.organizeImports" } },
    apply = true
  })
end

return {
  { "LuaCATS/luassert", name = "luassert-types", lazy = true },
  { "LuaCATS/busted",   name = "busted-types",   lazy = true },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library",     words = { "vim%.uv" } },
            { path = "luassert-types/library", words = { "assert" } },
            { path = "busted-types/library",   words = { "describe", "it" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      require("lspconfig").lua_ls.setup { capabilities = capabilities }
      require("lspconfig").ts_ls.setup { capabilities = capabilities }

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          vim.keymap.set({ "n", "v" }, "grf", function() vim.lsp.buf.format() end,
            { desc = 'LSP: format buffer', buffer = args.buf })
          vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
            { buffer = args.buf })

          if client.name == "ts_ls" then
            vim.api.nvim_buf_create_user_command(args.buf, "OrganizeImports", organize_imports, {})
            vim.keymap.set("n", "gro", "<cmd>OrganizeImports<CR>", { desc = 'LSP: Organize imports' })
          end

          if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              desc = 'Format the current buffer on save',
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  }
}
