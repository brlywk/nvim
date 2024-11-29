return {
    "otavioschwanck/arrow.nvim",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        -- or if using `mini.icons`
        -- { "echasnovski/mini.icons" },
    },
    opts = {
        show_icons = true,
        leader_key = 'm',        -- Recommended to be a single key
        buffer_leader_key = 'M', -- Per Buffer Mappings
        mappings = {
            toggle = 'a',
        },
        index_keys = "123456789zxcbnmZXVBNM,fghjklAFGHJKLwrstyuiopWRTYUIOP"
    }
}
