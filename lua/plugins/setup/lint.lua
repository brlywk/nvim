--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------
local helper = require "config.helper"
local lint = require "lint"

local web_formats = { "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" }

-- LINTERs to use (note that most LSPs have their own lint functionality anyway)
lint.linters_by_ft = {
    --
}

-- setup eslint
local eslint = lint.linters.eslint
---@diagnostic disable-next-line: assign-type-mismatch
eslint.cmd = function()
    local eslint_bin = vim.fn.getcwd() .. "/node_modules/.bin/eslint"
    if vim.fn.executable(eslint_bin) == 1 then
        return eslint_bin
    end

    return "eslint"
end

local function lint_callback()
    -- if we have a "web format", check which linter to call
    local ft = vim.bo.filetype
    if vim.tbl_contains(web_formats, ft) then
        lint.try_lint "eslint"
    else
        -- no "web format", call pre-configured linter
        lint.try_lint()
    end
end

-- lint on BufWritePost
vim.api.nvim_create_autocmd({ "BufWritePost" }, { callback = lint_callback })

-- set keymap if a linter is found and ready
vim.keymap.set("n", "<leader>cL", lint_callback, { desc = "Lint file" })
