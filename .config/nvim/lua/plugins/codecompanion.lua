return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"j-hui/fidget.nvim",
	},
	init = function()
		require("custom.fidget-spinner"):init()
	end,

	opts = {
		strategies = {
			chat = {
				adapter = {
					name = "openrouter",
					model = "openrouter/free",
				},
			},
			inline = {
				adapter = {
					name = "openrouter",
					model = "openrouter/free",
				},
			},
		},
		-- NOTE: The log_level is in `opts.opts`
		opts = {
			log_level = "DEBUG", -- or "TRACE"
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
	keys = {
		{ "<leader>ct", "<cmd>CodeCompanionChat toggle<CR>", desc = "toggle codecompanion" },
		{ "<leader>i", "<cmd>CodeCompanion<CR>", desc = "codecompanion" },
		{ "<leader>i", "<cmd>CodeCompanion<CR>", mode = "v", desc = "codecompanion" },
	},
}
