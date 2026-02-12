---@diagnostic disable:undefined-global
local M = {}

---Format the cmd_name given as a command that can be run (e.g. in Keymaps)
---@param cmd_name string Name of the command
---@return string
M.cmd = function(cmd_name)
    return ":" .. cmd_name .. "<CR>"
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

---Files used to identify a project using biome.
M.biome_config_files = { "biome.json", "biome.jsonc" }
---Files used to identify a project using prettier.
M.prettier_config_files = {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.mjs",
    ".prettierrc.toml",
    "prettier.config.js",
    "prettier.config.cjs",
    "prettier.config.mjs",
}

M.is_biome_project = function()
    return vim.fs.root(0, M.biome_config_files) ~= nil
end

M.is_prettier_project = function()
    return vim.fs.root(0, M.prettier_config_files) ~= nil
end

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
