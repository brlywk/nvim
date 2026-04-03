--------------------------------------------------------------------------------
-- LSPs to use
--------------------------------------------------------------------------------

vim.lsp.enable(require("config.lsp_servers").enable_servers)

--------------------------------------------------------------------------------
-- Global config (runs once)
--------------------------------------------------------------------------------

-- for all language servers: if there is no specific root marker, check if
-- we are in a git controlled folder
vim.lsp.config("*", {
    root_markers = { ".git" },
})

-- diagnostics settings
vim.diagnostic.config {
    virtual_text = true,
    signs = {
        priority = 20,
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
    },
    severity_sort = true,
}

-- override all LSP floating windows to use the same border
local border_type = require("plugins.theme").border_style
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = border_type
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

--------------------------------------------------------------------------------
-- LSP attach (local to buffer)
--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_global_config", { clear = true }),
    callback = function(args)
        local set = vim.keymap.set
        local opts = { noremap = true, silent = true, buffer = args.buf }

        opts.desc = "Code actions"
        set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        opts.desc = "Format with server"
        set("n", "<leader>cF", vim.lsp.buf.format, opts)
        opts.desc = "Restart server"
        set("n", "<leader>cR", "<cmd>LspRestart<CR>", opts)
        opts.desc = "Rename symbol"
        set("n", "<leader>cr", vim.lsp.buf.rename, opts)
        opts.desc = "Virtual line diagnostics"
        set("n", "<leader>cv", function()
            local vline_visible = vim.diagnostic.config(nil).virtual_lines or false
            vim.diagnostic.config {
                virtual_lines = not vline_visible,
                ---@diagnostic disable-next-line
                virtual_text = vline_visible,
            }
        end, opts)
    end,
})

--------------------------------------------------------------------------------
-- User commands (nvim-lspconfig equivalents for native LSP)
--------------------------------------------------------------------------------

vim.api.nvim_create_user_command("LspRestart", function()
    local clients = vim.lsp.get_clients { bufnr = 0 }
    for _, client in ipairs(clients) do
        client:stop()
    end
    vim.defer_fn(function()
        vim.cmd "do FileType"
    end, 200)
end, { desc = "Restart LSP clients for current buffer" })

vim.api.nvim_create_user_command("LspInfo", function()
    vim.cmd "checkhealth vim.lsp"
end, { desc = "Show LSP client info" })

vim.api.nvim_create_user_command("LspLog", function()
    vim.cmd("edit " .. vim.lsp.log.get_filename())
end, { desc = "Open LSP log file" })
