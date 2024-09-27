-- [nfnl] Compiled from fnl/config/utils.fnl by https://github.com/Olical/nfnl, do not edit.
local function toggle_test_file()
  local path = vim.fn.expand("%:h:t")
  local filename = vim.fn.expand("%:t")
  if (string.sub(filename, 1, 5) == "test_") then
    return vim.cmd.edit(("src/" .. path .. "/" .. string.sub(filename, 6)))
  else
    return vim.cmd.edit(("test/" .. path .. "/test_" .. filename))
  end
end
return {["toggle-test-file"] = toggle_test_file}
