-- important to set mapleader first so that plugins etc.
-- use the correct mapleader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- load general settings
require "config.options"

-- load helper functions
require "config.helper"

-- load keymaps
require "config.keymap"

-- load autocommands
require "config.autocommands"

-- keep this last: load lazy.vim to load plugins
require "config.lazy"
