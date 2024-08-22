-- [nfnl] Compiled from fnl/plugins/debbug.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local dap = require("dap")
  local dapui = require("dapui")
  dapui.setup()
  local function _2_()
    return dapui.open()
  end
  dap.listeners.before.attach["dapui_config"] = _2_
  local function _3_()
    return dapui.open()
  end
  dap.listeners.before.launch["dapui_config"] = _3_
  local function _4_()
    return dapui.close()
  end
  dap.listeners.before.event_terminated["dapui_config"] = _4_
  local function _5_()
    return dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = _5_
  return nil
end
local function _6_()
  return vim.keymap.set({"n", "i"}, "<F8>", "<cmd>DapToggleBreakpoint<cr>", {desc = "Toggle Breakpoint"})
end
local function _7_()
  local dap_python = require("dap-python")
  dap_python.setup("/Users/dan/.local/pipx/venvs/debugpy/bin/python")
  vim.keymap.set({"n", "i"}, "<C-M-d>", ":lua require('dap-python').test_method()<CR>", {desc = "Debug Python method", noremap = true})
  vim.keymap.set({"n", "i"}, "<localleader>dc", ":lua require('dap-python').test_class()<CR>", {desc = "Debug Python class", noremap = true})
  return vim.keymap.set({"v"}, "<C-M-d>", "<ESC>:lua require('dap-python').debug_selection()<CR>", {desc = "Debug Python selection", noremap = true})
end
return {{"rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}, config = _1_}, {"mfussenegger/nvim-dap", config = _6_}, {"mfussenegger/nvim-dap-python", ft = "python", dependencies = {"mfussenegger/nvim-dap", "mfussenegger/nvim-dap-ui"}, config = _7_}}
