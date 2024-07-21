----- setup -----
local file_name_with_parent_dir = function()
	local file_name = vim.fn.expand("%:t")
	local file_path = vim.fn.expand("%:p")
	local file_dir = vim.fn.fnamemodify(file_path, ":h")
	local dir_name = vim.fn.fnamemodify(file_dir, ":t")
	local display_name = dir_name .. "/" .. file_name

	return file_name ~= "" and display_name or ""
end

require("lualine").setup({
	options = {
		section_separators = "",
		component_separators = "",
		disabled_filetypes = { "alpha" },
	},
	sections = {
		lualine_c = {
			file_name_with_parent_dir,
		},
		lualine_x = {
			{
				"filetype",
				separator = " | ",
			},
			"encoding",
			{
				"fileformat",
				symbols = {
					unix = " ", -- apple uses LF in modern versions, too
					dos = " ",
					mac = "󰀶 ", -- if it's CR, it's an old macOS version (OS X)
				},
			},
		},
	},
})
