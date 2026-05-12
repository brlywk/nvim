--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------
local lint = require "lint"
local ft = require "config.lsp_filetypes"
local merge = require("config.helper").merge
local has_root = require("config.helper").has_root

local web_formats = merge(ft.javascript, ft.typescript)
local eslint_formats = merge(web_formats, { "svelte", "vue", "astro" })
local oxlint_config_files = ft.config_files.oxlint
local eslint_config_files = ft.config_files.eslint

lint.linters_by_ft = {
    -- add linters here if they are not run as LSP anyway...
}

-- setup eslint (use project version if found, global daemon otherwise)
local eslint = lint.linters.eslint

-- find the correct eslint executable to use
---@diagnostic disable-next-line: assign-type-mismatch
eslint.cmd = function()
    local eslint_bin = vim.fs.joinpath(vim.fn.getcwd(), "/node_modules/.bin/eslint")
    if vim.fn.executable(eslint_bin) == 1 then
        return eslint_bin
    end

    return "eslint_d"
end

local function lint_callback()
    local filetype = vim.bo.filetype

    if has_root(oxlint_config_files) and vim.tbl_contains(web_formats, filetype) then
        lint.try_lint "oxlint"
    elseif has_root(eslint_config_files) and vim.tbl_contains(eslint_formats, filetype) then
        lint.try_lint "eslint"
    else
        lint.try_lint()
    end
end

-- lint on BufWritePost
vim.api.nvim_create_autocmd({ "BufWritePost" }, { callback = lint_callback })

-- set keymap if a linter is found and ready
vim.keymap.set("n", "<leader>cL", lint_callback, { desc = "Lint file" })
