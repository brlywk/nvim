local M = {}

M.javascript = {
    "javascript",
    "javascriptreact",
}

M.typescript = {
    "typescript",
    "typescriptreact",
}

M.json = {
    "json",
    "jsonc",
}

M.html = {
    "html",
}

M.css = {
    "css",
    "scss",
}

M.graphql = {
    "graphql",
    "graphqls",
}

M.markdown = {
    "markdown",
    "markdown.mdx",
}

M.yaml = {
    "yaml",
    "yaml.docker-compose",
    "yaml.gitlab",
}

--- Merges multiple filetype lists into one
---@param ... string[]
---@return string[]
M.merge = function(...)
    local result = {}
    for _, list in ipairs { ... } do
        vim.list_extend(result, list)
    end
    return result
end

return M
