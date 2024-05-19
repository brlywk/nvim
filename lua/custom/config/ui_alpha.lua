----- dashboard config -----

local dashboard = require "alpha.themes.dashboard"
local logo = [[
░░░    ░░  ░░░░░░░   ░░░░░░   ░░    ░░  ░░  ░░░    ░░░
▒▒▒▒   ▒▒  ▒▒       ▒▒    ▒▒  ▒▒    ▒▒  ▒▒  ▒▒▒▒  ▒▒▒▒
▒▒ ▒▒  ▒▒  ▒▒▒▒▒    ▒▒    ▒▒  ▒▒    ▒▒  ▒▒  ▒▒ ▒▒▒▒ ▒▒
▓▓  ▓▓ ▓▓  ▓▓       ▓▓    ▓▓   ▓▓  ▓▓   ▓▓  ▓▓  ▓▓  ▓▓
██   ████  ███████   ██████     ████    ██  ██      ██

    ]]

local function getGreeting(name)
    local tableTime = os.date "*t"
    local datetime = os.date " %Y-%m-%d   %H:%M:%S"
    local hour = tableTime.hour
    local greetingsTable = {
        [1] = "  Go to bed",
        [2] = "  Good morning",
        [3] = "  Hello there",
        [4] = "  Good evening",
        [5] = "󰖔  Good night",
    }
    local greetingIndex = 0
    if hour == 23 or hour < 7 then
        greetingIndex = 1
    elseif hour < 12 then
        greetingIndex = 2
    elseif hour >= 12 and hour < 18 then
        greetingIndex = 3
    elseif hour >= 18 and hour < 21 then
        greetingIndex = 4
    elseif hour >= 21 then
        greetingIndex = 5
    end
    return " " .. datetime .. "\t" .. greetingsTable[greetingIndex] .. ", " .. name
end

local userName = "Christoph"
local greeting = getGreeting(userName)
-- dashboard.section.header.val = vim.split(logo .. "\n" .. greeting, "\n")
local subheader = {
    type = "group",
    val = {
        { type = "padding", val = 1 },
        { type = "text", val = greeting, opts = { hl = "qfLineNr", position = "center" } },
        { type = "padding", val = 1 },
    },
    position = "center",
}

dashboard.section.buttons.val = {
    dashboard.button("i", "    new file", ":ene <BAR> startinsert<CR>"),
    -- dashboard.button("e", "    file tree", ":Neotree<CR>"),
    -- dashboard.button("e", "    file tree", ":Telescope file_browser<CR>"),
    dashboard.button("e", "    file tree", ":Oil<CR>"),
    dashboard.button("r", "    recent files", ":Telescope oldfiles<CR>"),
    dashboard.button("f", "󰥨    find file", ":Telescope find_files<CR>"),
    dashboard.button("g", "󰱼    find text", ":Telescope live_grep<CR>"),
    -- dashboard.button("g", "    open git", ":LazyGit<CR>"),
    dashboard.button("l", "    lazy", ":Lazy<CR>"),
    dashboard.button("c", "    config", ":e ~/.config/nvim<CR>"),
    dashboard.button("q", "󰩈    quit", ":qa<CR>"),
}

for _, button in ipairs(dashboard.section.buttons.val) do
    button.opts.hl = "Normal"
    button.opts.hl_shortcut = "Label"
end

dashboard.section.header.val = vim.split(logo, "\n")
dashboard.section.header.opts.hl = "String"
dashboard.section.buttons.opts.hl = "Label"
dashboard.section.footer.opts.hl = "Keyword"

dashboard.opts.layout = {
    { type = "padding", val = 2 },
    dashboard.section.header,
    subheader,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 2 },
    dashboard.section.footer,
}

---- setup -----

local lv = require "lazy"

if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
            lv.show()
        end,
    })
end

require("alpha").setup(dashboard.opts)

vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
        local stats = lv.stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "󱐋 " .. stats.count .. " plugins loaded in " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
    end,
})
