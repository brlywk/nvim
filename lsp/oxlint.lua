-- NOTE: Currently unused as oxlint is setup as a "regular linter" via nvim-lint

local ft = require "config.lsp_filetypes"
local merge = require("config.helper").merge

---@type vim.lsp.Config
return {
    cmd = { "oxlint", "--lsp" },
    filetypes = merge(ft.javascript, ft.typescript),
    -- note that vue, svelte and astro don't work for linting Svelte, Vue and
    -- Astro yet
    root_markers = ft.config_files.oxlint,
    settings = {
        -- run = 'onType',
        -- configPath = nil,
        -- tsConfigPath = nil,
        -- unusedDisableDirectives = 'allow',
        -- typeAware = false,
        -- disableNestedConfig = false,
        -- fixKind = 'safe_fix',
    },
}
