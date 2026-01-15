local set = vim.keymap.set
local opts = { silent = true, noremap = true }
local cmd = require("config.helper").cmd

require("which-key").add { "<leader>l", group = "Language: TypeScript" }

opts.desc = "Inspect type"
set("n", "<leader>lt", cmd "TwoslashQueriesInspect", opts)
