vim.api.nvim_create_user_command('Eline', function(opts)
  local arg = opts.args
  local path, line, col = arg:match('^(.*):(%d+):(%d+)$')
  if not path then
    path, line = arg:match('^(.*):(%d+)$')
  end
  path = path or arg

  vim.cmd.edit(vim.fn.fnameescape(vim.fn.expand(path)))

  if line then
    local ok = pcall(vim.api.nvim_win_set_cursor, 0, { tonumber(line), col and (tonumber(col) - 1) or 0 })
    if ok then
      vim.cmd('normal! zz')
    end
  end
end, {
  nargs = 1,
  complete = 'file',
  desc = 'Edit file, optionally jumping to :line[:col] (e.g. :Eline path/to/file.lua:52)',
})
