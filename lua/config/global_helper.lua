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
