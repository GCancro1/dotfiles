return {
	"folke/lazydev.nvim",
	ft = "lua",
	cond = function()
		return vim.fn.getcwd() == vim.fn.expand("~/.config/nvim")
			or vim.fn.getcwd() == vim.fn.expand("~/dotfiles/.config/nvim")
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

