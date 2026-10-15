return {
		"MagicDuck/grug-far.nvim",
		cmd = "GrugFar",
		opts = {},
		keys = {
			{
				"<leader>ra",
				function()
					require("grug-far").open()
				end,
				desc = "Search and Replace",
			},

			{
				"<leader>rv",
				function()
					require("grug-far").open({
						visualSelectionUsage = "operate-within-range",
					})
				end,
				mode = { "n", "x" },
				desc = "Search/Replace Selection",
			},

			{
				"<leader>rf",
				function()
					require("grug-far").open({
						prefills = {
							paths = vim.fn.expand("%"),
						},
					})
				end,
				desc = "Search/Replace Current File",
			},
		},
	}
