require("arrow").setup {
    show_icons = true,
    leader_key = "m",
    buffer_leader_key = "M",
    mappings = {
        toggle = "a",
    },
    index_keys = "123456789zxcbnmZXVBNM,fghjklAFGHJKLwrstyuiopWRTYUIOP",
    window = {
        border = require("plugins.theme").border_style,
    },
}
