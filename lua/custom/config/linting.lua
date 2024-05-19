----- setup -----
local lint = require "lint"

-- eslint_d has not been updated in a while, so only regular eslint for now
local eslint = "eslint"

lint.linters_by_ft = {
    go = { "golangcilint" },
    -- lua = { "luacheck" }, -- needs luarocks installed

    javascript = { eslint },
    javascriptreact = { eslint },
    typescript = { eslint },
    typescriptreact = { eslint },

    astro = { eslint },
}

-- linter and keymap should only be active / set if linting is enabled,
-- i.e. linting has not been explicitely disabled in a project config
local neoconf = require "neoconf"
local should_lint = neoconf.get("linter", { linter = true })

if should_lint then
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
            -- by filetype
            lint.try_lint()

            -- always run spellcheck
            lint.try_lint "codespell"
        end,
    })

    -- keymaps
    vim.keymap.set("n", "<leader>cl", function()
        lint.try_lint()
    end, { desc = "Lint file" })
end
