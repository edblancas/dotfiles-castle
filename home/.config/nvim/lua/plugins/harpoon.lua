-- [nfnl] Compiled from fnl/plugins/harpoon.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local h = require("harpoon")
  local lst = h:list()
  h:setup()
  local function _2_()
    return lst:add()
  end
  vim.keymap.set("n", "<leader>ba", _2_)
  local function _3_()
    return h.ui:toggle_quick_menu(h:list())
  end
  vim.keymap.set("n", "<C-e>", _3_)
  local function _4_()
    return lst:select(1)
  end
  vim.keymap.set("n", "<M-D-1>", _4_)
  local function _5_()
    return lst:select(2)
  end
  vim.keymap.set("n", "<M-D-2>", _5_)
  local function _6_()
    return lst:select(3)
  end
  vim.keymap.set("n", "<M-D-3>", _6_)
  local function _7_()
    return lst:select(4)
  end
  vim.keymap.set("n", "<M-D-4>", _7_)
  local function _8_()
    return lst:prev()
  end
  vim.keymap.set("n", "<leader>bp", _8_)
  local function _9_()
    return lst:next()
  end
  return vim.keymap.set("n", "<leader>bn", _9_)
end
return {{"ThePrimeagen/harpoon", branch = "harpoon2", dependencies = {"nvim-lua/plenary.nvim"}, config = _1_}}
