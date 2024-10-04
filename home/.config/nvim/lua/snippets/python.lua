-- [nfnl] Compiled from fnl/snippets/python.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local str = autoload("nfnl.string")
local core = autoload("nfnl.core")
local test_file = "import unittest\n\nclass Test{}(unittest.TestCase):\n    def test_{}(self):\n        self.assertEqual({}(), ...)\n\n\nif __name__ == '__main__':\n    unittest.main()"
local fun = "def {}({}):\n    {}\n"
local function camel_to_snake(str0)
  local function _2_(c)
    return ("_" .. string.lower(c))
  end
  return string.gsub(str0, "%u", _2_)
end
local function snake_to_camel(str0)
  local str_without_underscore
  local function _3_(c)
    return string.upper(string.sub(c, 2))
  end
  str_without_underscore = string.gsub(str0, "_%a", _3_)
  return (string.lower(string.sub(str_without_underscore, 1, 1)) .. string.upper(string.sub(str_without_underscore, 1, 1)) .. string.sub(str_without_underscore, 2))
end
local function rep_snake(index)
  local function _4_(arg)
    local word = core["get-in"](arg, {1, 1})
    return camel_to_snake(word)
  end
  return f(_4_, {index})
end
local function rep_camel(index)
  local function _5_(arg)
    local word = core["get-in"](arg, {1, 1})
    return snake_to_camel(word)
  end
  return f(_5_, {index})
end
return {s("test-file", fmt(test_file, {i(1), rep_snake(1), i(0)})), s("pattern-file", fmt((fun .. "\n\n" .. test_file), {i(1), i(2), i(0, "..."), rep_camel(1), rep(1), rep(1)}))}
