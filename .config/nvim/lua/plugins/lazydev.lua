return {
	"folke/lazydev.nvim",
	ft = "lua",
	cond = function()
		return vim.fn.getcwd() == vim.fn.expand("~/.config/nvim")
	end,
	opts = {
		library = {
			{
				path = "${3rd}/luv/library",
				words = { "vim%.uv" },
			},
		},
	},
}
