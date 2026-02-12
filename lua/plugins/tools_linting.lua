return {
    "mfussenegger/nvim-lint",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        ---- Setup ----
        local helper = require "config.helper"
        local lint = require "lint"

        local web_formats = { "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" }

        lint.linters_by_ft = {
            c = { "clangtidy" },
            cc = { "clangtidy" },
            cpp = { "clangtidy" },
            gdscript = { "gdlint" },
            go = { "golangcilint" },
            h = { "clangtidy" },
            hh = { "clangtidy" },
            hpp = { "clangtidy" },
            -- lua = { "luacheck" },
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
                -- biome linting is handled via LSP diagnostics
                if helper.is_biome_project() then
                    return
                end

                lint.try_lint "eslint"
            else
                -- no "web format", call pre-configured linter
                lint.try_lint()
            end
        end

        -- lint on BufWritePre
        vim.api.nvim_create_autocmd({ "BufWritePre" }, { callback = lint_callback })

        -- set keymap if a linter is found and ready
        vim.keymap.set("n", "<leader>cL", lint_callback, { desc = "Lint file" })
    end,
}
