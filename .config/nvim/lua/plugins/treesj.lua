return {
	"Wansmer/treesj",
	keys = {
		{ "<leader>x", function() require("treesj").toggle({ split = { recursive = true } }) end, desc = "Treesj toggle" },
	},
	opts = { use_default_keymaps = false, max_join_length = 150 },
}
