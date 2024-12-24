local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require "telescope.config".values

local M = {}

local live_multigrep = function(opts)
  -- default setup for the setup
  opts = opts or {}
  -- if we pass one or the curren work dir
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local pieces = vim.split(prompt, "  ")
      local args = { "rg" }
      if pieces[1] then
        table.insert(args, "-e")
        table.insert(args, pieces[1])
      end

      if pieces[2] then
        table.insert(args, "-g")
        table.insert(args, pieces[2])
      end

      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten {
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  -- picker is the screen: finder (find the opts), sorter, previewer, make the entries and display
  pickers.new(opts, {
    debounce = 1000,
    prompt_title = "Multi Grep",
    finder = finder,
    -- normal previewer
    previewer = conf.grep_previewer(opts),
    -- dont sort it at all, will be sorted by rg command
    sorter = require('telescope.sorters').empty(),
  }):find()
end


M.setup = function()
  vim.keymap.set("n", "<leader>fg", live_multigrep)
end

return M
