-- [nfnl] Compiled from fnl/snippets/lua.fnl by https://github.com/Olical/nfnl, do not edit.
local function req()
  local function _1_(import_name)
    local function _2_(parts)
      return parts[#parts]
    end
    return (_2_(vim.split(import_name[1][1], ".", true)) or "")
  end
  return _1_
end
return {s("req1", fmt("local {} = require('{}')", {i(1, "default"), rep(1)})), s("req", fmt("local {} = require '{}'", {f(req(), {1}), i(1)}))}
