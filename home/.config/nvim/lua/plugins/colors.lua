-- [nfnl] Compiled from fnl/plugins/colors.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local theme = require("tokyonight")
  local theme_util = require("tokyonight.util")
  local function _2_(colors)
    colors.bg_statusline = theme_util.darken(colors.bg_dark, 0.5)
    return nil
  end
  local function _3_(hl, c)
    hl.TelescopeNormal = {bg = c["bg-dark"], fg = c["fg-dark"]}
    hl.TelescopeBorder = {bg = c["bg-dark"], fg = c["fg-dark"]}
    hl.TelescopePromptNormal = {bg = c["bg-dark"]}
    hl.TelescopePromptBorder = {bg = c["bg-dark"], fg = c["fg-dark"]}
    hl.TelescopePromptTitle = {bg = c["bg-dark"], fg = c["fg-dark"]}
    hl.TelescopePreviewTitle = {bg = c["bg-dark"], fg = c["fg-dark"]}
    hl.TelescopeResultsTitle = {bg = c["bg-dark"], fg = c["fg-dark"]}
    return nil
  end
  theme.setup({style = "night", transparent = vim.g.transparent_enabled, styles = {comments = {italic = true}, floats = "dark", functions = {}, keywords = {italic = true}, sidebars = "dark", variables = {}}, on_colors = _2_, on_highlights = _3_, terminal_colors = true})
  return vim.cmd("colorscheme tokyonight")
end
return {{"rose-pine/neovim", name = "rose-pine"}, {"Mofiqul/dracula.nvim"}, {"folke/tokyonight.nvim", priority = 1000, dependencies = {"nvim-tree/nvim-web-devicons"}, config = _1_, lazy = false}}
