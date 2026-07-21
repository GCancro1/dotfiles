return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	priority = 1000,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		preview = {
			filetypes = { "markdown", "codecompanion" },
			ignore_buftypes = {},
			ignore_filetypes = {},
			modes = { "n", "no", "c" },
			hybrid_modes = { "n" },
		},
		markdown = {
			enable = true,
			headings = { enable = true },
			code_blocks = { enable = true },
			block_quotes = { enable = true },
			horizontal_rules = { enable = true },
			list_items = { enable = true },
			checkboxes = { enable = true },
			inline_codes = { enable = true },
			links = { enable = true },
			images = { enable = true },
			tables = { enable = true },
		},
		markdown_inline = { enable = true },
		html = { enable = true },
		latex = { enable = true },
	},
	keys = {
		{ "<leader>mv", "<cmd>Markview toggle<cr>", desc = "Toggle Markview" },
		{ "<leader>ms", "<cmd>Markview splitToggle<cr>", desc = "Toggle Markview Split" },
	},
}