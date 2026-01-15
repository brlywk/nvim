local set = vim.keymap.set
local opts = { silent = true, noremap = true }

require("which-key").add { "<leader>l", group = "Language: Zig" }

-- organize imports on save; doing this on PreBufWrite seems to cause some weird
-- issues that tend to mess up the undo history
opts.desc = "Sort imports"
set("n", "<leader>li", function()
    vim.lsp.buf.code_action {
        ---@diagnostic disable-next-line
        context = { only = { "source.organizeImports" } },
        apply = true,
    }
end, opts)
