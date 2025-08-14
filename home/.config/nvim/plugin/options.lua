local opt = vim.opt

opt.inccommand = 'split'

opt.smartcase = true
opt.ignorecase = true

opt.number = true
opt.relativenumber = false

opt.splitbelow = true
opt.splitright = true

opt.shada = { "'10", "<0", "s10", "h" }

opt.timeoutlen = 300

opt.updatetime = 250

vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

opt.showmode = false

opt.mouse = 'a'

opt.undofile = true

opt.signcolumn = 'yes'

opt.cursorline = true

opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

opt.cursorline = true

opt.breakindent = true

opt.foldopen = "block,insert,jump,mark,percent,quickfix,search,tag,undo"
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""
opt.foldlevel = 99

opt.shell = 'nu'

opt.winborder = 'single'
