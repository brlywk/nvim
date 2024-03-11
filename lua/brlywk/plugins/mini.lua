return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		--  Removing Buffers  ------------------------------------
		require("mini.bufremove").setup()

		vim.keymap.set("n", "<leader>bx", function()
			require("mini.bufremove").delete(0, false)
		end, { desc = "Delete Buffer" })

		vim.keymap.set("n", "<leader>bX", function()
			require("mini.bufremove").delete(0, true)
		end, { desc = "Force Delete Buffer" })

		--  Keymapping Clues  ------------------------------------
		local miniclue = require("mini.clue")
		miniclue.setup({
			triggers = {
				-- Leader triggers
				{ mode = "n", keys = "<Leader>" },
				{ mode = "x", keys = "<Leader>" },

				-- Built-in completion
				{ mode = "i", keys = "<C-x>" },

				-- `g` key
				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },

				-- Marks
				{ mode = "n", keys = "'" },
				{ mode = "n", keys = "`" },
				{ mode = "x", keys = "'" },
				{ mode = "x", keys = "`" },

				-- Registers
				{ mode = "n", keys = '"' },
				{ mode = "x", keys = '"' },
				{ mode = "i", keys = "<C-r>" },
				{ mode = "c", keys = "<C-r>" },

				-- Window commands
				{ mode = "n", keys = "<C-w>" },

				-- `z` key
				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },
			},

			clues = {
				-- Enhance this by adding descriptions for <Leader> mapping groups
				miniclue.gen_clues.builtin_completion(),
				miniclue.gen_clues.g(),
				miniclue.gen_clues.marks(),
				miniclue.gen_clues.registers(),
				miniclue.gen_clues.windows(),
				miniclue.gen_clues.z(),

				-- Leader Subgroups
				{ mode = "n", keys = "<Leader>b", desc = "+Buffer" },
				{ mode = "n", keys = "<Leader>c", desc = "+Code" },
				{ mode = "n", keys = "<Leader>d", desc = "+Debug" },
				{ mode = "n", keys = "<Leader>l", desc = "+Lazy / Mason" },
				{ mode = "n", keys = "<Leader>s", desc = "+Search (Flash)" },
				{ mode = "n", keys = "<Leader>f", desc = "+Find / File" },
				{ mode = "n", keys = "<Leader>g", desc = "+Git" },
				{ mode = "n", keys = "<Leader>o", desc = "+Obsidian" },
				{ mode = "n", keys = "<Leader>r", desc = "+Refactor" },
				{ mode = "n", keys = "<Leader>v", desc = "+Session Management" },
				{ mode = "n", keys = "<Leader>w", desc = "+Window (Split)" },
				{ mode = "n", keys = "<Leader>x", desc = "+Trouble" },
				{ mode = "n", keys = "<Leader>y", desc = "+System Clipboard" },
				{ mode = "n", keys = "<Leader>z", desc = "Why not Zoidberg? (/)_(;,,;)_(/)" },
			},
		})

		--  Highlight Word under cursor  ------------------------------------
		require("mini.cursorword").setup()

		--  Move text chunks around with Alt = hjkl  ------------------------------------
		require("mini.move").setup()

		--  Enhanced text operators  ------------------------------------
		--  Keymap
		--		g=	Evaluate text and replace with result
		--		gx	Exchange text regions (gxx for single line)
		--		gm	Duplicate line (gmm single line)
		--		gs	Sort text (selection)
		require("mini.operators").setup()

		-- Splits / Joings (expands) argument lists ----------------------------------
		-- Keymap: gS
		require("mini.splitjoin").setup()

		-- Super amazing surround mappings ----------------------------------
		require("mini.surround").setup()
	end,
}
