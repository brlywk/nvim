local navic = require "nvim-navic"
local devicons = require "nvim-web-devicons"

--------------------------------------------------------------------------------
-- Navic setup (needs to be configured before incline.nvim)
--------------------------------------------------------------------------------
navic.setup {
    -- lazy update cursor movement... activate if large files have performance issues
    lazy_update_context = false,
    lsp = {
        auto_attach = false,
        preference = {
            -- single language lsp
            "lua_ls",
            "gopls",
            "ols",
            "rust_analyzer",
            "taplo",
            "yamlls",

            -- precedence of the umpftillion of web lsps
            "ts_ls",
            "astro",
            "svelte",
            "emmet_ls",
            "html",
            "tailwindcss",
            "cssls",

            -- other servers
            "templ",
        },
    },
}

-- attach navic to any active lsp
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_navic", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client or not client.server_capabilities.documentSymbolProvider then
            return
        end
        navic.attach(client, ev.buf)
    end,
})

--------------------------------------------------------------------------------
-- Incline setup
--------------------------------------------------------------------------------
require("incline").setup {
    window = {
        padding = 0,
        margin = { horizontal = 0, vertical = 0 },
    },
    render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
            filename = "[No Name]"
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        local res = {
            ft_icon and { " ", ft_icon, " ", guibg = "", guifg = ft_color } or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            guibg = "",
        }
        if props.focused then
            for _, item in ipairs(navic.get_data(props.buf) or {}) do
                table.insert(res, {
                    { " > ", group = "NavicSeparator" },
                    { item.icon, group = "NavicIcons" .. item.type },
                    { item.name, group = "NavicText" },
                })
            end
        end
        table.insert(res, " ")
        return res
    end,
}
