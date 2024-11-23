-- [nfnl] Compiled from fnl/plugins/lualine.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local lsp = autoload("config.lsp")
local core = autoload("nfnl.core")
local function lsp_connection()
  local message = lsp["get-progress-message"]()
  if ((message.status == "begin") or (message.status == "report")) then
    return (message.msg .. " : " .. message.percent .. "%% \239\130\150")
  elseif (message.status == "end") then
    return "\239\131\136"
  elseif ((message.status == "") and not vim.tbl_isempty(vim.lsp.get_clients(0))) then
    return "\239\131\136"
  else
    return "\239\130\150"
  end
end
local my_setup = {options = {theme = "tokyonight", icons_enabled = true, globalstatus = true, section_separators = {left = "", right = ""}, component_separators = {left = "|", right = "|"}}, winbar = {lualine_a = {}}, inactive_winbar = {lualine_a = {}}, disabled_filetypes = {statusline = {}, winbar = {}}, sections = {lualine_a = {"mode"}, lualine_b = {"branch"}, lualine_c = {"diff", {"diagnostics", sections = {"error", "warn", "info", "hint"}, sources = {"nvim_lsp"}}, {"filename", file_status = true, path = 1, shorting_target = 40}}, lualine_x = {{lsp_connection}, "filetype"}, lualine_y = {"progress"}, lualine_z = {"location"}}, inactive_sections = {lualine_a = {}, lualine_b = {}, lualine_c = {{"filename", file_status = true, path = 1}}, lualine_x = {}, lualine_y = {}, lualine_z = {}}, extensions = {"neo-tree", "oil", "nvim-dap-ui", "fugitive", "aerial", "quickfix", "lazy", "mason"}}
local colors = {bg = "#202328", fg = "#bbc2cf", yellow = "#ECBE7B", cyan = "#008080", darkblue = "#081633", green = "#98be65", orange = "#FF8800", violet = "#a9a1e1", magenta = "#c678dd", blue = "#51afef", red = "#ec5f67"}
local conditions
local function _3_()
  return (vim.fn.empty(vim.fn.expand("%:t")) ~= 1)
end
local function _4_()
  return (vim.fn.winwidth(0) > 80)
end
local function _5_()
  local filepath = vim.fn.expand("%:p:h")
  local gitdir = vim.fn.finddir(".git", (filepath .. ";"))
  return (gitdir and (string.len(gitdir) > 0) and (string.len(gitdir) < string.len(filepath)))
end
conditions = {buffer_not_empty = _3_, hide_in_width = _4_, check_git_workspace = _5_}
local config = {options = {component_separators = "", section_separators = "", theme = {normal = {c = {fg = colors.fg, bg = colors.bg}}, inactive = {c = {fg = colors.fg, bg = colors.bg}}}}, sections = {lualine_a = {}, lualine_b = {}, lualine_y = {}, lualine_z = {}, lualine_c = {}, lualine_x = {}}, inactive_sections = {lualine_a = {}, lualine_b = {}, lualine_y = {}, lualine_z = {}, lualine_c = {}, lualine_x = {}}}
local function ins_left(component)
  return table.insert(config.sections.lualine_c, component)
end
local function ins_right(component)
  return table.insert(config.sections.lualine_x, component)
end
local function _6_()
  return "\226\150\138"
end
ins_left({_6_, color = {fg = colors.blue}, padding = {left = 0, right = 1}})
local function _7_()
  return "\239\140\140"
end
local function _8_()
  local mode_color = {n = colors.red, i = colors.green, v = colors.blue, ["\22"] = colors.blue, V = colors.blue, c = colors.magenta, no = colors.red, s = colors.orange, S = colors.orange, ["\19"] = colors.orange, ic = colors.yellow, R = colors.violet, Rv = colors.violet, cv = colors.red, ce = colors.red, r = colors.cyan, rm = colors.cyan, ["r?"] = colors.cyan, ["!"] = colors.red, t = colors.red}
  return {fg = mode_color[vim.fn.mode()]}
end
ins_left({_7_, color = _8_, padding = {right = 1}})
ins_left({"filesize", cond = conditions.buffer_not_empty})
ins_left({"filename", cond = conditions.buffer_not_empty, color = {fg = colors.magenta, gui = "bold"}})
ins_left({"location"})
ins_left({"progress", color = {fg = colors.fg, gui = "bold"}})
ins_left({"diagnostics", sources = {"nvim_diagnostic"}, symbols = {error = "\239\129\151 ", warn = "\239\129\177 ", info = "\239\129\170 "}, diagnostics_color = {error = {fg = colors.red}, warn = {fg = colors.yellow}, info = {fg = colors.cyan}}})
local function _9_()
  return "%="
end
ins_left({_9_})
local function _10_()
  local msg = "No Active Lsp"
  local buf_ft = vim.api.nvim_get_option_value("filetype", {buf = 0})
  local clients = vim.lsp.get_clients()
  if (next(clients) == nil) then
    return msg
  else
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if (filetypes and (vim.fn.index(filetypes, buf_ft) ~= -1)) then
      return client.name
    else
    end
  end
  return msg
end
ins_left({_10_, icon = "\239\130\133 LSP:", color = {fg = "#ffffff", gui = "bold"}})
ins_right({"o:encoding", fmt = string.upper, cond = conditions.hide_in_width, color = {fg = colors.green, gui = "bold"}})
ins_right({"fileformat", fmt = string.upper, color = {fg = colors.green, gui = "bold"}, icons_enabled = false})
ins_right({"branch", icon = "\239\145\191", color = {fg = colors.violet, gui = "bold"}})
ins_right({"diff", symbols = {added = "\239\131\190 ", modified = "\243\176\157\164 ", removed = "\239\133\134 "}, diff_color = {added = {fg = colors.green}, modified = {fg = colors.orange}, removed = {fg = colors.red}}, cond = conditions.hide_in_width})
local function _13_()
  return "\226\150\138"
end
ins_right({_13_, color = {fg = colors.blue}, padding = {left = 1}})
local function _14_()
  local lualine = require("lualine")
  return lualine.setup(config)
end
return {{"nvim-lualine/lualine.nvim", config = _14_}}
