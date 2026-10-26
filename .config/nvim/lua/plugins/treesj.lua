return {
	"Wansmer/treesj",
	keys = {
		{
			"<leader>tj",
			function()
				require("treesj").toggle({ split = { recursive = true } })
			end,
			desc = "Treesj toggle",
		},{
			"<leader>tn",
			function()
				require("treesj").toggle({ split = { recursive = true } })
			end,
			desc = "Treesj toggle",
		},
	},
	opts = { use_default_keymaps = false, max_join_length = 150 },
}
