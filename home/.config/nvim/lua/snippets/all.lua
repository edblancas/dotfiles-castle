-- [nfnl] Compiled from fnl/snippets/all.fnl by https://github.com/Olical/nfnl, do not edit.
local function same(index)
  local function _1_(arg)
    print(vim.inspect(arg))
    return ""
  end
  return f(_1_, {index, index})
end
local function rep_impl(index)
  local function _2_(arg)
    return arg[1][1]
  end
  return f(_2_, {index})
end
local function _3_()
  return os.date("%D - %H:%M")
end
return {s("todo", fmt("{}: {}", {c(1, {t("TODO"), t("NOTE"), t("FIXME"), t("BUG")}), i(0)})), s("currtime", f(_3_)), s("print-same", fmt("example: {}, function: {}", {i(1), same(1)})), s("rep-impl", fmt("example: {}, function: {}", {i(1), rep_impl(1)}))}
