return {
  { "HiPhish/rainbow-delimiters.nvim" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        auto_install = true,
        sync_install = false,
        ignore_install = {},
        modules = {},
        indent = { enable = true },
        highlight = {
          enable = true,
          disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-context' },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = true,
    main = 'nvim-treesitter.configs',
    opts = {
      textobjects =
      {
        select =
        {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps =
          {
            -- Capture groups defined in textobjects.scm
            af = "@function.outer",
            ['if'] = "@function.inner",
            ac = "@class.outer",
            -- Optionally set descriptions to the mappings
            ic = { query = "@class.inner", desc = "Select inner part of a class region" }
          },
          -- Select mode (default is charwise 'v')
          selection_modes =
          {
            ["@parameter.outer"] = "v",           -- charwise
            ["@function.outer"] = "V",            -- linewise
            ["@class.outer"] = "<c-v>"
          },                                      -- blockwise
          -- Include surrounding whitespace (default is false)
          include_surrounding_whitespace = false
        }
      }
    }
  }
}
