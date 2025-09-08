return {
    "mfussenegger/nvim-lint",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        ---- Setup ----
        local lint = require "lint"

        -- eslint_d has not been updated in a while, so only regular eslint for now
        local eslint = "eslint"

        lint.linters_by_ft = {
            go = { "golangcilint" },
            lua = { "luacheck" },

            gdscript = { "gdlint" },

            javascript = { eslint },
            javascriptreact = { eslint },
            typescript = { eslint },
            typescriptreact = { eslint },

            c = { "clangtidy" },
            cc = { "clangtidy" },
            cpp = { "clangtidy" },
            h = { "clangtidy" },
            hh = { "clangtidy" },
            hpp = { "clangtidy" },
        }

        -- set keymap if a linter is found and ready
        vim.keymap.set("n", "<leader>cL", function()
            lint.try_lint()
        end, { desc = "Lint file" })
    end,
}
