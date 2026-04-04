local M = {}

---Callback to run all hooks plugins might need for proper setups
M.callback = function(ev)
    -- treesitter
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
        if not ev.data.active then
            vim.cmd.packadd "nvim-treesitter"
        end
        vim.cmd "TSUpdate"
    end
end

return M
