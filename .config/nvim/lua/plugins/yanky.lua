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
		{ "<c-n>", "<Plug>(YankyNextEntry)" },
		{ "]p", "<Plug>(YankyPutIndentAfterLinewise)" },
		{ "[p", "<Plug>(YankyPutIndentBeforeLinewise)" },
		{ "]P", "<Plug>(YankyPutIndentAfterLinewise)" },
		{ "[P", "<Plug>(YankyPutIndentBeforeLinewise)" },
		-- { ">p", "<Plug>(YankyPutIndentAfterShiftRight)" },
		-- { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)" },
		-- { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)" },
		-- { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)" },
		-- { "=p", "<Plug>(YankyPutAfterFilter)" },
		-- { "=P", "<Plug>(YankyPutBeforeFilter)" },
	},
}
