-- [nfnl] Compiled from fnl/plugins/harpoon.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local h = require("harpoon")
  local lst = h:list()
  h:setup()
  local function _2_()
    lst:add()
    return {desc = "Harpoon add"}
  end
  vim.keymap.set("n", "<leader>ha", _2_)
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
    return lst:replace_at(1)
  end
  vim.keymap.set("n", "<leader><M-D-1>", _8_)
  local function _9_()
    return lst:replace_at(2)
  end
  vim.keymap.set("n", "<leader><M-D-2>", _9_)
  local function _10_()
    return lst:replace_at(3)
  end
  vim.keymap.set("n", "<leader><M-D-3>", _10_)
  local function _11_()
    return lst:replace_at(4)
  end
  vim.keymap.set("n", "<leader><M-D-4>", _11_)
  local function _12_()
    return lst:prev()
  end
  vim.keymap.set("n", "<leader>hp", _12_, {desc = "Harpoon previous"})
  local function _13_()
    return lst:next()
  end
  return vim.keymap.set("n", "<leader>hn", _13_, {desc = "Harpoon next"})
end
return {{"ThePrimeagen/harpoon", branch = "harpoon2", dependencies = {"nvim-lua/plenary.nvim"}, config = _1_}}
