return {
  {
    "qvalentin/helm-ls.nvim",
    ft = "helm",
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    submodules = false,
    event = "BufReadPost",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
          if not lang then return end
          local ok, parsers = pcall(require, "nvim-treesitter.parsers")
          if not (ok and parsers[lang]) then return end
          local installed = require("nvim-treesitter.config").get_installed()
          if not vim.tbl_contains(installed, lang) then
            require("nvim-treesitter").install({ lang })
          end
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = {
      on_attach = function(buf)
        if vim.bo[buf].filetype == "markdown" then return false end
      end,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "BufReadPost",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          selection_modes = {
            ["@parameter.outer"] = "v",
            ["@function.outer"] = "V",
            ["@class.outer"] = "<c-v>",
          },
          include_surrounding_whitespace = false,
        },
      })
      local select = require("nvim-treesitter-textobjects.select")
      vim.keymap.set({ "x", "o" }, "af", function()
        select.select_textobject("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "if", function()
        select.select_textobject("@function.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ac", function()
        select.select_textobject("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ic", function()
        select.select_textobject("@class.inner", "textobjects")
      end)
    end,
  },
}
