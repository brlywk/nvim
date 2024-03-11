return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        require('lualine').setup({
            options = {
                section_separators = '', component_separators = ''
            },
            sections = {
                lualine_x = {
                    {
                        'copilot',
                        separator = " | ",
                    },
                    {
                        'filetype',
                        separator = " | ",
                    },
                    'encoding',
                    {
                        'fileformat',
                        symbols = {
                            unix = ' ', -- apple uses LF in modern versions, too
                            dos = ' ',
                            mac = '󰀶 ', -- if it's CR, it's an old macOS version (OS X)
                        }
                    },
                }
            },
        })
    end,
}
