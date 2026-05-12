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

---Returns the correct comment chars for the current buffer / language.
---@return string start_part Proper starting comment string, e.g. "//"
---@return string repeat_char Reapating char to use, e.g. "/"
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

---Returns a full github.com URL for the provided repo
---@param repo string Name of the repo, e.g. "folke/snacks.nvim"
---@return string URL Full github.com URL, e.g. https://github.com/folke/snacks.nvim
M.github_url = function(repo)
    return "https://github.com/" .. repo
end

---Merges multiple lists into one
---@param ... any[]
---@return any[]
M.merge = function(...)
    local result = {}
    for _, list in ipairs { ... } do
        vim.list_extend(result, list)
    end
    return result
end

---Check if the current directories is the root directory for a list of marker
---files
---@param root_markers string[] List of marker files to check for
---@return boolean
M.has_root = function(root_markers)
    return vim.fs.root(0, root_markers) ~= nil
end

return M
