local function organize_imports()
  vim.lsp.buf.code_action({
    context = { only = { "source.organizeImports" } },
    apply = true,
  })
end

return {
  { 'github/copilot.vim' },
  { "LuaCATS/luassert",  name = "luassert-types", lazy = true },
  { "LuaCATS/busted",    name = "busted-types",   lazy = true },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
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

      vim.keymap.set("n", "<leader>rf", function() vim.lsp.buf.format() end, { desc = 'LSP: format buffer' })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client.name == "ts_ls" then
            vim.api.nvim_buf_create_user_command(args.buf, "OrganizeImports", organize_imports,
              { desc = 'Organize Imports' })
          end

          if client:supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
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
