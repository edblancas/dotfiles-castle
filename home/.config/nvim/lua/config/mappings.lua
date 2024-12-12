-- [nfnl] Compiled from fnl/config/mappings.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local core = autoload("nfnl.core")
nvim.set_keymap("n", "<space>", "<nop>", {noremap = true})
nvim.set_keymap("n", "<leader><space>", ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>", {noremap = true, desc = "nohlsearch/diffupdate"})
nvim.set_keymap("n", "<C-w>T", ":tab split<CR>", {noremap = true, silent = true})
vim.keymap.set("i", "<C-;>", "()<Left>", {noremap = true})
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
vim.keymap.set({"n", "v", "i"}, "<D-s>", "<cmd>w<CR>")
vim.keymap.set({"n", "v", "i"}, "<D-M-s>", "<cmd>wall<CR>")
vim.keymap.set({"n"}, "<leader>]", ":bn<cr>")
vim.keymap.set({"n"}, "<leader>[", ":bp<cr>")
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", {desc = "Rename <tag>"})
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true})
vim.keymap.set({"n"}, "<F10>", "<C-w>|")
vim.keymap.set({"n"}, "<D-F10>", "<C-w>_")
vim.keymap.set({"n", "i"}, "<F1>", "<nop>")
vim.keymap.set({"n"}, "-", "<CMD>Oil<CR>", {desc = "Open parent directory"})
local function _2_(args)
  local range = nil
  local conform = require("conform")
  if (args.count ~= -1) then
    local end_line = vim.api.nvim_buf_get_lines(0, (args.line2 - 1), args.line2, true)[1]
    range = {start = {args.line1, 0}, ["end"] = {args.line2, end_line:len()}}
  else
  end
  return conform.format({async = true, lsp_format = "fallback", range = range})
end
vim.api.nvim_create_user_command("Format", _2_, {range = true})
vim.keymap.set({"n", "v", "i"}, "<M-D-l>", "<CMD>Format<CR>", {desc = "Format with comform"})
local function _4_(_)
  local cwd = vim.fn.getcwd()
  local folder_name = vim.fn.fnamemodify(cwd, ":t")
  local file_path = vim.fn.expand("%")
  return vim.fn.setreg("+", (folder_name .. "/" .. file_path))
end
vim.api.nvim_create_user_command("CopyFilePathProject", _4_, {})
local function _5_(_)
  local cwd = vim.fn.getcwd()
  local folder_name = vim.fn.fnamemodify(cwd, ":t")
  local file_path = vim.fn.expand("%")
  return vim.fn.setreg("+", (folder_name .. "/" .. file_path))
end
vim.api.nvim_create_user_command("CopyFilePath", _5_, {})
local function _6_()
  return vim.keymap.set("n", "<C-M-o>", "<cmd>OptimizeImports<cr>", {noremap = true})
end
vim.api.nvim_create_autocmd("FileType", {pattern = {"typescript", "typescriptreact"}, callback = _6_})
local function _7_()
  return vim.keymap.set("n", "<C-M-o>", "<cmd>PyrightOrganizeImports<cr>", {noremap = true})
end
vim.api.nvim_create_autocmd("FileType", {pattern = "python", callback = _7_})
vim.api.nvim_create_autocmd("VimLeave", {pattern = "*", command = "silent !zellij action switch-mode normal"})
vim.keymap.set({"n", "v", "i"}, "<C-C>", "<CMD>cclose<CR>", {desc = "Close quickfix"})
vim.keymap.set({"n", "i"}, "<F1>", ":lua vim.lsp.buf.hover()<CR>", {desc = "Hover doc"})
local function _8_()
  local get_notes_root
  local function _9_()
    local dot_git_path = vim.fn.finddir("~/Documents/dev/notes/", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
  end
  get_notes_root = _9_
  local tel = require("telescope.builtin")
  return tel.find_files({cwd = get_notes_root(), prompt_title = "Search Notes", find_command = {"rg", "--files", "--glob", "*.md", "--glob", "*.markdown", "--glob", "*.txt", "--glob", "*.org"}})
end
vim.api.nvim_create_user_command("OpenNotes", _8_, {})
vim.keymap.set({"n", "i"}, "<M-D-n>", "<cmd>OpenNotes<cr>", {desc = "Open notes"})
local function _10_()
  local get_notes_root
  local function _11_()
    local dot_git_path = vim.fn.finddir("~/Documents/dev/notes/", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
  end
  get_notes_root = _11_
  local tel = require("telescope.builtin")
  return tel.live_grep({cwd = get_notes_root(), prompt_title = "Grep Notes", find_command = {"rg", "--files", "--glob", "*.md", "--glob", "*.markdown", "--glob", "*.txt", "--glob", "*.org"}})
end
vim.api.nvim_create_user_command("GrepNotes", _10_, {})
vim.keymap.set({"n", "i"}, "<S-D-n>", "<cmd>GrepNotes<cr>", {desc = "Grep notes"})
local function _12_(_)
  local file_name = vim.fn.input("Enter the note name: ")
  local notes_dir = "~/Documents/notes/"
  local full_path = vim.fn.expand((notes_dir .. file_name))
  vim.cmd(("edit " .. full_path))
  return vim.cmd("write")
end
vim.api.nvim_create_user_command("CreateNote", _12_, {})
vim.keymap.set({"t"}, "<esc><esc>", "<c-\\><c-n>")
local function _13_()
  vim.cmd.new()
  vim.cmd.set("nonumber")
  vim.cmd.set("norelativenumber")
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 12)
  core.assoc(vim.wo, "winfixheight", true)
  return vim.cmd.term()
end
vim.keymap.set({"n"}, "<leader>tt", _13_, {desc = "Toggle terminal"})
return {}
