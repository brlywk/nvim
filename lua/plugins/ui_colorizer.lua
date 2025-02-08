return {
    "norcalli/nvim-colorizer.lua",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("colorizer").setup(nil, {
            names = false,
            tailwind = true,
        })
    end,
}
