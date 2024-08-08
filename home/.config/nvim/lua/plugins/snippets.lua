-- [nfnl] Compiled from fnl/plugins/snippets.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local ls = require("luasnip")
  local types = require("luasnip.util.types")
  local ls_loader = require("luasnip.loaders.from_lua")
  ls.config.set_config({history = true, updateevents = "TextChanged,TextChangedI", ext_opts = {[types.choiceNode] = {active = {virt_text = {{"<-", "Error"}}}}}})
  local function _2_()
    if ls.expand_or_jumpable() then
      return ls.expand_or_jump()
    else
      return nil
    end
  end
  vim.keymap.set({"i", "s", "n"}, "<M-D-k>", _2_, {silent = true})
  local function _4_()
    if ls.jumpable(-1) then
      return ls.jump(-1)
    else
      return nil
    end
  end
  vim.keymap.set({"i", "s", "n"}, "<M-D-j>", _4_, {silent = true})
  local function _6_()
    if ls.choice_active() then
      return ls.change_choice(1)
    else
      return nil
    end
  end
  vim.keymap.set({"i"}, "<M-D-l>", _6_, {silent = true})
  return ls_loader.load({paths = "~/.config/nvim/lua/snippets"})
end
return {{"L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp", config = _1_}}
