-- important to set mapleader first so that plugins etc.
-- use the correct mapleader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- load general settings
require "config.options"

-- load global helper functions
require "config.global_helper"

-- load keymaps
require "config.keymap"

-- load autocommands
require "config.autocommands"

-- check if we are within a Godot project and do some extra setup
require "config.godot"

-- keep this last: load lazy.vim to load plugins
require "config.lazy"
