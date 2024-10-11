-- [nfnl] Compiled from fnl/snippets/python.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local test_code = "def {}({}):\n    {}\n\n\nimport unittest\n\nclass Test{}(unittest.TestCase):\n    def test_{}(self):\n        self.assertEqual({}({}), ...)\n"
local test_file = "\nif __name__ == '__main__':\n    unittest.main()\n"
local test_main = "\ndef main():\n    test = Test{}()\n    test.test_{}()\n"
local function camel_to_snake(str)
  local function _2_(c)
    return ("_" .. string.lower(c))
  end
  return string.gsub(str, "%u", _2_)
end
local function snake_to_camel(str)
  local str_without_underscore
  local function _3_(c)
    return string.upper(c)
  end
  str_without_underscore = string.gsub(str, "_", _3_)
  return (string.upper(string.sub(str_without_underscore, 1, 1)) .. string.sub(str_without_underscore, 2))
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
return {s("test-file", fmt((test_code .. test_file), {i(1), i(2), i(0, "..."), rep_camel(1), rep(1), rep(1), rep(1)})), s("test-main", fmt((test_code .. test_main), {i(1), i(2), i(0, "..."), rep_camel(1), rep(1), rep(1), rep(1), rep_camel(1), rep(1)}))}
