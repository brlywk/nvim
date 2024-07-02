-- set mapleader first
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- import other settings
require "brlywk.options"

-- import keymaps
require "brlywk.keymap"

-- load autocommands
require "brlywk.autocommands"

-- load helper functions
require "brlywk.helper"
