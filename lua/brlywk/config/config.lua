-- general options that I like and such
local opt = vim.opt

-- show line number on current line
opt.number = true

-- use relative numbers by default
opt.relativenumber = true

-- highlight line
opt.cursorline = true

-- set tabstops as cthulhu intended them to be
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- preserve indentation on line breaks
opt.breakindent = true

-- save undo history
opt.undofile = true
-- save undo history for almost infinite undoing
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- use system clipboard
opt.clipboard = "unnamedplus"

-- disable backups and swaps
opt.swapfile = false
opt.backup = false

-- case-insensitive search unless capital or \C in search
opt.ignorecase = true
opt.smartcase = true

-- keep signcolumn enabled
opt.signcolumn = "yes"

-- don't show mode in command line
opt.showmode = false

-- better completion experience
opt.completeopt = "menuone,noselect"

-- make sure colors are true :P
opt.termguicolors = true

-- make searching a little bit better
opt.hlsearch = false
opt.incsearch = true

-- set how many characters should always be visible below when scrolling down
opt.scrolloff = 8

-- decrease update time (when swap will be written)
opt.updatetime = 250

-- decrease mapped sequence timeout (will display mini.clue sooner)
opt.timeoutlen = 300

-- set line length 'indicator'
opt.colorcolumn = "100"

-- I don't like ~ as end of buffer signs
opt.fillchars = { eob = " " }

-- Add filename to top of open buffer
-- opt.winbar = "%=%m %f"

-- split windows to the right and bottom
opt.splitright = true
opt.splitbelow = true

-- hide 'no write since last change' error
opt.hidden = true

-- required for Obsidian.nvim to function properly... try this out, otherwise
-- deactivate Obsidian UI features
opt.conceallevel = 2
