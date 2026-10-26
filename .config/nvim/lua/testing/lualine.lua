return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = { theme = "base16" },
	config = function()
		require("lualine").setup({
			sections = {
				lualine_c = {
					{ "filename", path = 2 }, -- Absolute path
				},
			},
		})
	end,
}
