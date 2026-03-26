return {
  {
    'echasnovski/mini.statusline',
    version = '*',
    config = function()
      local statusline = require('mini.statusline')

      -- Bold variant of the filename hl group, re-applied on colorscheme change
      local function define_root_hl()
        local hl = vim.api.nvim_get_hl(0, { name = 'MiniStatuslineFilename', link = false })
        vim.api.nvim_set_hl(0, 'MiniStatuslineFilenameRoot', vim.tbl_extend('force', hl, { bold = true }))
      end
      vim.schedule(define_root_hl)
      vim.api.nvim_create_autocmd('ColorScheme', { callback = define_root_hl })

      statusline.setup({
        content = {
          active = function()
            local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
            local git           = statusline.section_git({ trunc_width = 75 })
            local diff          = statusline.section_diff({ trunc_width = 75 })
            local diagnostics   = statusline.section_diagnostics({ trunc_width = 75 })
            local lsp           = statusline.section_lsp({ trunc_width = 75 })
            local fileinfo      = statusline.section_fileinfo({ trunc_width = 120 })
            local location      = statusline.section_location({ trunc_width = 75 })
            local search        = statusline.section_searchcount({ trunc_width = 75 })

            -- For special buffers (oil, terminal, quickfix, etc.) use the default
            local filename
            local is_special = vim.bo.buftype ~= '' or vim.fn.expand('%:p'):find('://')
            if is_special then
              filename = statusline.section_filename({ trunc_width = 140 })
            else
              local rel = vim.fn.expand('%:.')
              if rel == '' or rel:sub(1, 1) == '/' then
                -- File is outside cwd: show full path without bold prefix
                local fullpath = vim.fn.expand('%:p')
                rel = fullpath ~= '' and fullpath or '[No Name]'
                filename = '%#MiniStatuslineFilename#' .. rel
              else
                -- cwd folder name (bold) + relative path from cwd
                local cwd_name = vim.fn.fnamemodify(vim.uv.cwd() or '', ':t')
                filename = '%#MiniStatuslineFilenameRoot#' .. cwd_name .. '/'
                  .. '%#MiniStatuslineFilename#' .. rel
              end
              if vim.bo.modified then filename = filename .. ' [+]' end
              if vim.bo.readonly then filename = filename .. ' [-]' end
            end

            return statusline.combine_groups({
              { hl = mode_hl,                  strings = { mode } },
              { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics, lsp } },
              '%<',
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=',
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl,                  strings = { search, location } },
            })
          end,
        },
      })
    end,
  },
  { 'echasnovski/mini.surround', version = '*', config = true }
}
