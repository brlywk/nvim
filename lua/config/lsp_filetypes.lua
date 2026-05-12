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

M.config_files = {
    oxlint = {
        ".oxlintrc.json",
        ".oxlintrc.jsonc",
        "oxlint.config.ts",
    },
    oxfmt = {
        ".oxfmtrc.json",
        ".oxfmtrc.jsonc",
        "oxfmt.config.ts",
    },
    eslint = {
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        ".eslintrc.json",
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
        "eslint.config.ts",
        "eslint.config.mts",
        "eslint.config.cts",
    },
    prettier = {
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
    },
}

return M
