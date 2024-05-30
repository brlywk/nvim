----- setup -----
local lint = require "lint"

-- eslint_d has not been updated in a while, so only regular eslint for now
local eslint = "eslint"

lint.linters_by_ft = {
    go = { "golangcilint" },

    javascript = { eslint },
    javascriptreact = { eslint },
    typescript = { eslint },
    typescriptreact = { eslint },

    vue = { "biomejs" }, -- isn't it wonderful that the formatter is called "biome" but the linter "biomejs"?
}

-- linter and keymap should only be active / set if linting is enabled,
-- i.e. linting has not been explicitly disabled in a project config
local neoconf = require "neoconf"
local linter_conf = neoconf.get "linter" or {}
local disabled_linter = neoconf.get "linter.disable" or ""
local linters_for_ft = FILTER_OUT_KEYS(linter_conf, "disable")

-- check if language specific linter should run
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function(args)
        local ft = vim.api.nvim_get_option_value("filetype", { buf = args.buf })

        -- explicitly return if this filetypes linter has been disabled
        local ft_linters = lint.linters_by_ft[ft] or {}
        if #vim.tbl_keys(lint.linters_by_ft) > 0 and vim.list_contains(ft_linters, disabled_linter) then
            return
        end

        -- overwrite linters by ft if found in neoconf config
        if #vim.tbl_keys(linters_for_ft) > 0 then
            for ft_name, linter_overwrite in pairs(linters_for_ft) do
                lint.linters_by_ft[ft_name] = { linter_overwrite }
            end
        end

        -- try linting with assigned linter
        lint.try_lint()

        -- always try to lint with codespell if installed... if not just install it
        if require("mason-registry").is_installed "codespell" then
            lint.try_lint "codespell"
        else
            vim.cmd "MasonInstall codespell"
        end

        -- set keymap if a linter is found and ready
        vim.keymap.set("n", "<leader>cl", function()
            lint.try_lint()
        end, { desc = "Lint file" })
    end,
})
