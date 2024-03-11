-- Print the contents of a table
P = function(v)
	print(vim.inspect(v))
	return v
end

-- use Plenary to reload a module
RELOAD = function(...)
	return require("plenary.reload").reload_module(...)
end

-- reload and read a plugins
R = function(name)
	RELOAD(name)
	return require(name)
end
