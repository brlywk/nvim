return {
    "nvim-neotest/neotest",
    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-neotest/nvim-nio",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",

        -- test adapters
        "nvim-neotest/neotest-go",
        "rouge8/neotest-rust",
        "nvim-neotest/neotest-jest",
        "marilari88/neotest-vitest",
    },
    config = function()
        ---- Setup ----
        -- Go Go Go!
        local neotest_ns = vim.api.nvim_create_namespace "neotest"
        vim.diagnostic.config({
            virtual_text = {
                format = function(diagnostic)
                    local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                    return message
                end,
            },
        }, neotest_ns)

        -- Neotest setup
        local neotest = require "neotest"
        --- @diagnostic disable: missing-fields
        neotest.setup {
            adapters = {
                -- Go
                -- https://github.com/nvim-neotest/neotest-go
                require "neotest-go",

                -- Rust
                -- https://github.com/rouge8/neotest-rust
                require "neotest-rust",

                -- JavaScript
                -- https://github.com/nvim-neotest/neotest-jest
                require "neotest-jest" {
                    jestCommand = "npm test --",
                    jestConfigFile = "custom.jest.config.ts",
                    env = { CI = true },
                    cwd = function(path)
                        print("neotest-jest path: " .. path)
                        return vim.fn.getcwd()
                    end,
                },
                -- https://github.com/marilari88/neotest-vitest
                require "neotest-vitest",
            },
        }

        ---- Keymaps ----
        local set = vim.keymap.set
        local opts = { silent = true }

        opts.desc = "Cancel test run"
        set("n", "<leader>tC", ":lua require('neotest').run.stop()<CR>", opts)

        opts.desc = "Open output"
        set("n", "<leader>to", ":lua require('neotest').output.open({enter = true, auto_close = true})<CR>", opts)

        opts.desc = "Toggle output panel"
        set("n", "<leader>tp", ":lua require('neotest').output_panel.toggle()<CR>", opts)

        opts.desc = "Run nearest test"
        set("n", "<leader>tr", ":lua require('neotest').run.run()<CR>", opts)

        opts.desc = "Run all tests in file"
        set("n", "<leader>tR", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", opts)

        opts.desc = "Open summary"
        set("n", "<leader>ts", ":lua require('neotest').summary.toggle()<CR>", opts)

        opts.desc = "Toggle watching test"
        set("n", "<leader>tw", ":lua require('neotest').watch.toggle()", opts)

        opts.desc = "Toggle watching file"
        set("n", "<leader>tW", ":lua require('neotest').watch.toggle(vim.fn.expand('%'))", opts)
    end,
}
