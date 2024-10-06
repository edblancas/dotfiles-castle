-- [nfnl] Compiled from fnl/plugins/debug.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  vim.keymap.set({"n", "i"}, "<D-F8>", "<cmd>DapToggleBreakpoint<cr>", {desc = "Toggle Breakpoint"})
  vim.keymap.set({"n", "i"}, "<F7>", "<cmd>DapStepInto<cr>", {desc = "Debug Step Into"})
  vim.keymap.set({"n", "i"}, "<F8>", "<cmd>DapStepOver<cr>", {desc = "Debug Step Over"})
  vim.keymap.set({"n", "i"}, "<S-F8>", "<cmd>DapStepOut<cr>", {desc = "Debug Step Out"})
  vim.keymap.set({"n", "i"}, "<F9>", "<cmd>DapContinue<cr>", {desc = "Debug Continue"})
  return vim.keymap.set({"n", "i"}, "<D-F2>", "<cmd>DapTerminate<cr>", {desc = "Debug Terminate"})
end
local function _2_()
  local dapui = require("dapui")
  return dapui.toggle()
end
local function _3_()
  local dapui = require("dapui")
  return dapui.open({reset = true})
end
local function _4_()
  local dap = require("dap")
  local dapui = require("dapui")
  dapui.setup()
  local function _5_()
    return dapui.open()
  end
  dap.listeners.before.attach["dapui_config"] = _5_
  local function _6_()
    return dapui.open()
  end
  dap.listeners.before.launch["dapui_config"] = _6_
  local function _7_()
    return dapui.close()
  end
  dap.listeners.before.event_terminated["dapui_config"] = _7_
  local function _8_()
    return dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = _8_
  return nil
end
local function _9_()
  local dap_python = require("dap-python")
  dap_python.setup("/Users/dan/.local/pipx/venvs/debugpy/bin/python")
  vim.keymap.set({"n", "i"}, "<C-M-d>", ":lua require('dap-python').test_method()<CR>", {desc = "Debug Python method", noremap = true})
  vim.keymap.set({"n"}, "<localleader>dc", ":lua require('dap-python').test_class()<CR>", {desc = "Debug Python class", noremap = true})
  return vim.keymap.set({"v"}, "<C-M-d>", "<ESC>:lua require('dap-python').debug_selection()<CR>", {desc = "Debug Python selection", noremap = true})
end
return {{"mfussenegger/nvim-dap", config = _1_}, {"rcarriga/nvim-dap-ui", version = "v4.*", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}, keys = {{"<localleader>du", _2_, desc = "Toggle Debug UI"}, {"<localleader>dr", _3_, desc = "Reset Windows Debug UI"}}, config = _4_}, {"mfussenegger/nvim-dap-python", ft = "python", dependencies = {"mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui"}, config = _9_}}
