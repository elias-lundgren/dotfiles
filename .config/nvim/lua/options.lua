local opt = vim.opt
local g = vim.g

opt.title = true
opt.list = true
opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
opt.hlsearch = false
opt.clipboard = ""
opt.termguicolors = false
opt.scrolloff = 10
opt.showmode = false
opt.splitkeep = "screen"
opt.clipboard = ""
opt.cursorline = true
opt.cursorlineopt = "both"
opt.cmdheight = 0
opt.autochdir = false

opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2
opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.updatetime = 100
opt.timeoutlen = 400
opt.undofile = true

opt.winborder = "rounded"
opt.laststatus = 0

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.mapleader = " "
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

vim.diagnostic.config({ virtual_text = true })
-- vim.cmd("colorscheme base16-gruvbox-dark-hard")
