-- IMPORTANT: Set mapleader first!
vim.g.mapleader = " "
vim.g.maplocallebder = " "

local k = vim.keymap

-- I don't think I ever want top (accidentally) repeat macros multiple times
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
k.set("n", "<leader>'", "<C-^>", { noremap = true, silent = true, desc = "Jump to alternate buffer" })

-- close (delete) all buffers except the currently open ones
k.set("n", "<leader>bQ", "<cmd>%bd|e#|bd#<CR>", { silent = true, desc = "Close all except current" })

-- HANDLED BY MINI.MOVE:
-- In visual mode, allow J and K to move the selected text up and down
-- k.set('v', '<M-j>', ":m '>+1<CR>gv=gv")
-- k.set('v', '<M-k>', ":m '<-2<CR>gv=gv")

-- keep cursor in the middle of the screen when scrolling by have pages
k.set("n", "<C-d>", "<C-d>zz")
k.set("n", "<C-u>", "<C-u>zz")

-- keep cursor in the middle when searching
k.set("n", "n", "nzzzv")
k.set("n", "N", "Nzzzv")

-- delete single characters to void
k.set("n", "x", '"_x')

-- some convenient INSERT mode commands
-- k.set("i", "<C-h>", "<Left>")
-- k.set("i", "<C-l>", "<Right>")
-- k.set("i", "<C-j>", "<Down>")
-- k.set("i", "<C-k>", "<Up>")
-- k.set("i", "<C-b>", "<C-o>_")

-- window management
k.set("n", "<leader>wv", "<C-w>v", { desc = "[W]indow: Split [v]vertically" })
k.set("n", "<leader>wh", "<C-w>s", { desc = "[W]indow: Split [h]orizontaly" })
k.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "[W]indow: Close" })
k.set("n", "<leader>wX", "<C-w>o", { desc = "Close All Other Windows" })

-- easier movement between windows
k.set("n", "<C-h>", "<C-w>h")
k.set("n", "<C-l>", "<C-w>l")
k.set("n", "<C-j>", "<C-w>j")
k.set("n", "<C-k>", "<C-w>k")

-- pasting from system clipboard (default commands with prefix <leader>)
k.set("n", "<leader>yp", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
k.set("v", "<leader>yp", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
k.set("n", "<leader>yP", '"+P', { noremap = true, silent = true, desc = "Paste from clipboard" })
k.set("v", "<leader>yP", '"+P', { noremap = true, silent = true, desc = "Paste from clipboard" })

-- same for yanking
k.set("n", "<leader>yy", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
k.set("v", "<leader>yy", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })

-- allows replacement of the current word under the cursor
vim.keymap.set(
	"n",
	"<leader>ra",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace all word occurences" }
)
