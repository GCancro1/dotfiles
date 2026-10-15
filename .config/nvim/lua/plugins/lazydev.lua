return {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			{
				path = "${3rd}/luv/library",
				words = { "vim%.uv" },
			},
		},

		-- disable when a .luarc.json file is found
		enabled = function(root_dir)
			return not (vim.uv.fs_stat(root_dir .. "/.luarc.json") and true)
				or vim.fn.getcwd() == vim.fn.expand("~/.config/nvim")
				or vim.fn.getcwd() == vim.fn.expand("~/dotfiles/.config/nvim")
				or vim.fn.getcwd() == vim.fn.expand("~/dotfiles")
		end,
	},
}
