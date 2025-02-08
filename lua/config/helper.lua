-- print contents of lua table
P = function(t)
    print(vim.inspect(t))
    return t
end

-- use plenary to reload a module
RELOAD = function(...)
    local plenary, installed = pcall(function()
        require "plenary.reload"
    end)

    if installed then
        --- @diagnostic disable: undefined-field
        return plenary.reload_module(...)
    end
end

-- reload and re-parse a plugin
R = function(name)
    RELOAD(name)
    return require(name)
end

-- check if cwd is git controlled
CHECK_GIT = function()
    local git_dir = vim.fn.finddir(".git", ".;")
    return git_dir ~= ""
end

-- vim.tbl_filter() does not really do what I need for some things
FILTER_OUT_KEYS = function(table, ...)
    local remove_keys = { ... }
    local filtered_table = {}

    for key, value in pairs(table) do
        if not vim.list_contains(remove_keys, key) then
            filtered_table[key] = value
        end
    end

    return filtered_table
end
