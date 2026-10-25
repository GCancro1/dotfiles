return {
	"y3owk1n/undo-glow.nvim",
	opts = {
		animation = {
			enabled = false,
			duration = 300,
		},
	},
	keys = {
		{
			"u",
			function()
				require("undo-glow").undo()
			end,
		},
		{
			"<C-r>",
			function()
				require("undo-glow").redo()
			end,
		},
		{
			"p",
			function()
				require("undo-glow").paste_below()
			end,
		},
		{
			"P",
			function()
				require("undo-glow").paste_above()
			end,
		},
	},
}
