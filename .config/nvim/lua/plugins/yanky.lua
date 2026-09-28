return {
	"gbprod/yanky.nvim",
	opts = {},
	dependencies = { "folke/snacks.nvim" },
	keys = {
		{
			"<leader>p",
			function()
				Snacks.picker.yanky()
			end,
			mode = { "n", "x" },
			desc = "Open Yank History",
		},

		{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "YankyPutAfter" },
		{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "YankyPutBefore" },
		{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "" },
		{ "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "" },
		{ "<c-p>", "<Plug>(YankyPreviousEntry)", mode = "n", desc = "" },
		{ "<c-n>", "<Plug>(YankyNextEntry)" },
		{ "<c-p>", "<Plug>(YankyPreviousEntry)" },
		{ "n", "<c-n>", "<Plug>(YankyNextEntry)" },
		{ "n", "]p", "<Plug>(YankyPutIndentAfterLinewise)" },
		{ "n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)" },
		{ "n", "]P", "<Plug>(YankyPutIndentAfterLinewise)" },
		{ "n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)" },
		{ "n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)" },
		{ "n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)" },
		{ "n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)" },
		{ "n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)" },
		{ "n", "=p", "<Plug>(YankyPutAfterFilter)" },
		{ "n", "=P", "<Plug>(YankyPutBeforeFilter)" },
	},
}
