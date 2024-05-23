-- [nfnl] Compiled from fnl/config/settings.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local str = autoload("nfnl.string")
local nvim = autoload("nvim")
local core = autoload("nfnl.core")
nvim.ex.autocmd("FocusGained,BufEnter", "*", ":checktime")
nvim.ex.autocmd("FileType", "lua", "setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab")
nvim.ex.autocmd("FileType", "fennel", "setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab")
nvim.ex.autocmd("FileType", "clojure", "setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab")
nvim.ex.set("nowrap")
nvim.o.termguicolors = true
nvim.o.mouse = "a"
do
  local options = {encoding = "utf-8", spelllang = "en_us", backspace = "2", colorcolumn = "80", errorbells = true, number = true, ruler = true, completeopt = "menuone,noselect", wildmenu = true, wildignore = "*/tmp/*,*.so,*.swp,*.zip", ignorecase = true, smartcase = true, clipboard = "unnamedplus", list = true, listchars = str.join(",", {"tab:\226\150\182-", "trail:\226\128\162", "extends:\194\187", "precedes:\194\171", "eol:\194\172"}), expandtab = true, tabstop = 4, shiftwidth = 4, softtabstop = 4, undofile = true, splitbelow = true, splitright = true, hlsearch = true, signcolumn = "number", statusline = str.join(" ", {"[%n]", "%f", "%m%y%r%h%w%=%-35.(%{&fenc==\"\"?&enc:&fenc}", "[%{&ff}]", "[%L,%p%%]", "[%l,%c%V]", "%)%P"}), relativenumber = true, swapfile = false, backup = false, showmode = false}
  for option, value in pairs(options) do
    core.assoc(nvim.o, option, value)
  end
end
return {}
