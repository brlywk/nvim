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
-- i.e. linting has not been explicitly disabled in a project config
local neoconf = require "neoconf"
local should_lint = neoconf.get("linter", { linter = true })

-- check if language specific linter should run
if should_lint then
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
            lint.try_lint()
        end,
    })

    -- keymaps
    vim.keymap.set("n", "<leader>cl", function()
        lint.try_lint()
    end, { desc = "Lint file" })
end

-- check if spellchecking is installed and run spellcheck
if require("mason-registry").is_installed "codespell" then
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
            -- always run spellcheck
            lint.try_lint "codespell"
        end,
    })
end
