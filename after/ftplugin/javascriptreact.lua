-- lazyness, should really move this to a helper at some point...
local set = vim.keymap.set
local opts = { silent = true, noremap = true }

-- set which-key
require("which-key").add { "<leader>l", group = "Language: React" }

opts.desc = "Tailwind: Sort classes"
set("n", "<leader>lt", ":TailwindSort<CR>", opts)
opts.desc = "Tailwind: Toggle sort on save"
set("n", "<leader>lT", ":TailwindSortOnSaveToggle<CR>", opts)
