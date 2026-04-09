---@diagnostic disable:undefined-global
local M = {}

---Format the cmd_name given as a command that can be run (e.g. in keymaps)
---@param cmd_name string Name of the command
---@return string
M.cmd = function(cmd_name)
    return ":" .. cmd_name .. "<CR>"
end

---Creates the opts table used in keymaps
---@param desc? string Description of the keymap, shown in which-key etc. Defaults to `""`
---@param expr? boolean If `true`, the RHS is treated as an expression (like `v:count == 0 ? 'gk' : 'k'`). Defaults to `false`
---@param noremap? boolean If `false`, allows remapping. Defaults to `true`
---@param silent? boolean If `false`, echoes the command in the command line. Defaults to `true`
---@return { noremap: boolean, expr: boolean, silent: boolean, desc: string }
M.set_opts = function(desc, expr, noremap, silent)
    noremap = noremap == nil
    silent = silent == nil
    expr = expr == true
    desc = desc or ""

    return { noremap = noremap, expr = expr, silent = silent, desc = desc }
end

---Filter out all keys provided from the table.
---`vim.tbl_filter()` does not really do what I need for some things
---@param table any Really... ANY table
---@param ... string A list of table keys that should be filtered out
---@return table
M.filter_keys = function(table, ...)
    local remove_keys = { ... }
    local filtered_table = {}

    for key, value in pairs(table) do
        if not vim.list_contains(remove_keys, key) then
            filtered_table[key] = value
        end
    end

    return filtered_table
end

---Check if the current directory is git controlled.
---@return boolean
M.check_git = function()
    local git_dir = vim.fn.finddir(".git", ".;")
    return git_dir ~= ""
end

---Returns the correct comment chars for the current buffer / language.
---@return string Proper starting comment string, e.g. "//"
---@return string Reapating char to use, e.g. "/"
M.get_comment_chars = function()
    local cstring = vim.bo.commentstring
    if not cstring or cstring == "" then
        cstring = "// %s"
    end

    -- get part before %s
    local start_part = cstring:match "^(.*)%%s" or cstring
    start_part = vim.trim(start_part)
    local repeat_char = start_part:sub(-1, -1)

    return start_part, repeat_char
end

return M
