return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		-- NOTE: The log_level is in `opts.opts`
		opts = {
			log_level = "DEBUG", -- or "TRACE"
		},
		interactions = {
			chat = {
				adapter = { name = "openrouter", model = "openrouter/free" },
			},
			inline = {
				adapter = { name = "openrouter", model = "openrouter/free" },
			},
		},
		adapters = {
			http = {
				openrouter = function()
					return require("codecompanion.adapters").extend("openrouter", {
						env = {
							api_key = "file:~/openrouter.key",
						},
					})
				end,
			},
		},
	},
	keys = { { "<leader>ct", "<cmd>CodeCompanionChat toggle<CR>", {desc = "toggle codecompanion"}} },
}
