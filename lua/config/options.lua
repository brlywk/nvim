local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.scrolloff = 8
opt.inccommand = "split"
opt.showtabline = 0 -- never show tabline on top
opt.clipboard = "unnamedplus"
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.breakindent = true
opt.showmode = false
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true
opt.signcolumn = "yes" -- always show gutter on the left
opt.splitright = true
opt.splitbelow = true
opt.undofile = true
opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
opt.swapfile = false
opt.backup = false
opt.hidden = true -- hide "unchanged buffer" warnings
opt.fillchars = { eob = " " }
opt.updatetime = 250
opt.textwidth = 80
opt.formatoptions:append "c" -- automatically wrap comments
