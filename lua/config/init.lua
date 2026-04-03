-- important to set mapleader first so that plugins etc.
-- use the correct mapleader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- load general settings
require "config.options"

-- load keymaps
require "config.keymap"

-- load autocommands
require "config.autocommands"

-- helpers
require "config.helper"

-- language servers
require "config.lsp"
