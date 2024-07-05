----- setup -----
local lint = require("lint")

-- eslint_d has not been updated in a while, so only regular eslint for now
local eslint = "eslint"

lint.linters_by_ft = {
	go = { "golangcilint" },
	lua = { "luacheck" },

	javascript = { eslint },
	javascriptreact = { eslint },
	typescript = { eslint },
	typescriptreact = { eslint },
}

-- set keymap if a linter is found and ready
vim.keymap.set("n", "<leader>cl", function()
	lint.try_lint()
end, { desc = "Lint file" })
