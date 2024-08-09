-- [nfnl] Compiled from fnl/plugins/paredit.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local paredit = require("nvim-paredit")
  local function _2_()
    return {paredit.api.slurp_forwards, "Slurp forwards"}
  end
  local function _3_()
    return {paredit.api.slurp_backwards, "Slurp backwards"}
  end
  local function _4_()
    return {paredit.api.barf_forwards, "Barf forwards"}
  end
  local function _5_()
    return {paredit.api.barf_backwards, "Barf backwards"}
  end
  local function _6_()
    return paredit.cursor.place_cursor(paredit.wrap.wrap_enclosing_form_under_cursor("(", ")"), {mode = "insert", placement = "inner_end"})
  end
  local function _7_()
    return paredit.cursor.place_cursor(paredit.wrap.wrap_element_under_cursor("(", ")"), {mode = "insert", placement = "inner_end"})
  end
  local function _8_()
    return paredit.cursor.place_cursor(paredit.wrap.wrap_enclosing_form_under_cursor("( ", ")"), {mode = "insert", placement = "inner_start"})
  end
  local function _9_()
    return paredit.cursor.place_cursor(paredit.wrap.wrap_element_under_cursor("( ", ")"), {mode = "insert", placement = "inner_start"})
  end
  return paredit.setup({keys = {["<C-D-L>"] = {_2_}, ["<C-D-H>"] = {_3_}, ["<C-D-K>"] = {_4_}, ["<C-D-J>"] = {_5_}, ["<localleader>I"] = {_6_, "Wrap form insert tail"}, ["<localleader>W"] = {_7_, "Wrap element insert tail"}, ["<localleader>i"] = {_8_, "Wrap form insert head"}, ["<localleader>w"] = {_9_, "Wrap element insert head"}}})
end
return {{"julienvincent/nvim-paredit", lazy = true, ft = {"clojure", "fennel"}, config = _1_}, {"julienvincent/nvim-paredit-fennel", dependencies = {"julienvincent/nvim-paredit"}, lazy = true, ft = {"fennel"}, config = true}}
