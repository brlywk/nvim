-- remove auto-inser of comment leaders:
--   o = when pressing o/O in normal mode on a commented line
--   r = when pressing <CR> in insert mode on a commented line
--   t = auto-wrap text based on textwidth
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("formatoptions_override", { clear = true }),
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove { "o", "r", "t" }
    end,
})
