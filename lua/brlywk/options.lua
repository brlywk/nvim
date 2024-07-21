local opt = vim.opt

-- line numbers
opt.number = true
opt.relativenumber = true

-- always keep a few lines above and below in view on scrolling
opt.scrolloff = 8

-- show preview for incremental commands in a split
opt.inccommand = "split"

-- never show tabline
opt.showtabline = 0

-- use system clipboard
opt.clipboard = "unnamedplus"

-- cthulhu demands the following indent settings:
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.breakindent = true

-- hide mode in command line
opt.showmode = false

-- better searching
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- always show sign column to prevent buffer from jumping
opt.signcolumn = "yes"

-- split windows to right and below
opt.splitright = true
opt.splitbelow = true

-- save (almost) infinite undo history
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- disable backups and swaps
opt.swapfile = false
opt.backup = false

-- hide unchanged buffer warnings
opt.hidden = true

-- remove fill chars at the end of the buffer
opt.fillchars = { eob = " " }

-- decrease update time
opt.updatetime = 250

-- text wrapping for comments at 120 characters
opt.textwidth = 120
opt.formatoptions:append("c")
opt.colorcolumn = "+1"

-- Try nvim spellchecking
vim.cmd("syntax on") -- enabled syntax highlighting
opt.spell = true
opt.spelllang = { "en_us" }
opt.spelloptions:append("camel") -- better camelCase support
opt.spellcapcheck = "" -- disable checking for capital letters at the start of sentences
