-- IMPORTANT: Set mapleader first!
vim.g.mapleader = " "
vim.g.maplocallebder = " "

local k = vim.keymap

-- I don't think I ever want to (accidentally) repeat macros multiple times
k.set("n", "Q", "<Nop>", { noremap = true, silent = true })
k.set("n", "@@", "<Nop>", { noremap = true, silent = true })

-- shut vim up when pressing space
k.set({ "n", "v" }, "<space>", "<Nop>", { silent = true })

-- better moving lines up and down (move screen lines instead of 'real' lines when lines are wrapped)
k.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
k.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- buffer movement: set some keymaps (I like the way LazyVim does this)
k.set("n", "[b", vim.cmd.bprev, { noremap = true, silent = true })
k.set("n", "]b", vim.cmd.bnext, { noremap = true, silent = true })
k.set("n", "<leader>'", "<C-^>", { noremap = true, silent = true, desc = "Alternate buffer" })

-- close (delete) all buffers except the currently open ones
k.set("n", "<leader>bQ", "<cmd>%bd|e#|bd#<CR>", { silent = true, desc = "Close all except current" })

-- keep cursor in the middle of the screen when scrolling by have pages
k.set("n", "<C-d>", "<C-d>zz")
k.set("n", "<C-u>", "<C-u>zz")

-- keep cursor in the middle when searching
k.set("n", "n", "nzzzv")
k.set("n", "N", "Nzzzv")

-- delete single characters to void
k.set("n", "x", '"_x')

-- window management
k.set("n", "<leader>wv", "<C-w>v", { desc = "[W]indow: Split [v]vertically" })
k.set("n", "<leader>wh", "<C-w>s", { desc = "[W]indow: Split [h]orizontaly" })
k.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "[W]indow: Close" })
k.set("n", "<leader>wo", "<C-w>o", { desc = "Close all other windows" })

-- easier movement between windows
k.set("n", "<C-h>", "<C-w>h")
k.set("n", "<C-l>", "<C-w>l")
k.set("n", "<C-j>", "<C-w>j")
k.set("n", "<C-k>", "<C-w>k")

-- allows replacement of the current word under the cursor
k.set(
	"n",
	"<leader>ra",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace all word occurrences" }
)

-- special shortcut for Vue, as eslint_d for Vue needs flat config support enabled
k.set(
	"n",
	"<leader>cV",
	"<cmd>!ESLINT_USE_FLAT_CONFIG=true eslint_d restart<CR>",
	{ desc = "Enable eslint_d Vue override" }
)
