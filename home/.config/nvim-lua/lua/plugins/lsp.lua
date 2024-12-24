return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
	"folke/lazydev.nvim",
	ft = "lua", -- only load on lua files
	opts = {
	  library = {
	    -- See the configuration section for more details
	    -- Load luvit types when the `vim.uv` word is found
	    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
	  },
	},
      },
      { -- optional cmp completion source for require statements and module annotations
	"hrsh7th/nvim-cmp",
	opts = function(_, opts)
	  opts.sources = opts.sources or {}
	  table.insert(opts.sources, {
	    name = "lazydev",
	    group_index = 0, -- set group index to 0 to skip loading LuaLS completions
	  })
	end,
      },
    },
    config = function()
      require("lspconfig").lua_ls.setup {}

      vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format() end)

      vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
	  local client = vim.lsp.get_client_by_id(args.data.client_id)
	  if not client then return end

	  if client:supports_method('textDocument/formatting') then
	    -- Format the current buffer on save
	    vim.api.nvim_create_autocmd('BufWritePre', {
	      buffer = args.buf,
	      callback = function()
		vim.lsp.buf.format({bufnr = args.buf, id = client.id})
	      end,
	    })
	  end
	end,
      })
    end,
  }
}

