-- [nfnl] Compiled from fnl/config/settings.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local str = autoload("nfnl.string")
local nvim = autoload("nvim")
local core = autoload("nfnl.core")
nvim.ex.autocmd("FocusGained,BufEnter", "*", ":checktime")
nvim.ex.autocmd("FileType", "lua", "setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab")
nvim.ex.autocmd("FileType", "clojure,fennel,typescript,typescriptreact", "setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab")
nvim.ex.autocmd("FileType", "python", "setlocal formatoptions-=t")
local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", {clear = true})
vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "InsertLeave", "WinEnter"}, {desc = "Set relativenumber if not in insert mode", pattern = "*", command = "if &nu && mode() != 'i' | set rnu   | endif", group = numbertoggle})
vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter", "WinLeave"}, {desc = "Set absolute numbers if in insert mode or lose focus", pattern = "*", command = "if &nu                  | set nornu | endif", group = numbertoggle})
nvim.ex.set("nowrap")
nvim.o.mouse = "a"
do
  local options = {encoding = "utf-8", spelllang = "en_us", errorbells = true, relativenumber = true, number = true, completeopt = "menuone,noselect", wildmenu = true, wildignore = "*/tmp/*,*.so,*.swp,*.zip", ignorecase = true, smartcase = true, clipboard = "unnamedplus", listchars = str.join(",", {"tab:\226\150\182-", "trail:\226\128\162", "extends:\194\187", "precedes:\194\171", "eol:\194\172"}), expandtab = true, tabstop = 4, shiftwidth = 4, softtabstop = 4, undofile = true, splitbelow = true, splitright = true, hlsearch = true, signcolumn = "yes", foldlevel = 1, shell = "zsh", showbreak = "\226\134\179", textwidth = 80, breakindent = true, breakindentopt = "shift:4,sbr", cursorline = true, foldmethod = "expr", foldexpr = "v:lua.vim.treesitter.foldexpr()", foldtext = "", backup = false, foldenable = false, list = false, showmode = false, swapfile = false}
  for option, value in pairs(options) do
    core.assoc(nvim.o, option, value)
  end
end
vim.diagnostic.config({signs = false, virtual_text = false})
return {}
