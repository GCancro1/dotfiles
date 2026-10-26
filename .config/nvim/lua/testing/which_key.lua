return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	delay = 0,
	opts = {
		preset = "helix",
		spec = {
			{ "<leader>s", group = "Search", mode = { "n", "v" } },
			{ "<leader>S", group = "Session", mode = { "n", "v" } },
			{ "<leader>c", group = "code/quickfix", mode = { "n", "v" } },
			{ "<leader>f", group = "File", mode = { "n", "v" } },
			{ "<leader>t", group = "Toggle" },
			{ "<leader>b", group = "Debug", mode = { "n" } },
			{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			{ "gr", group = "LSP Actions", mode = { "n" } },
		},
		sort = { "alphanum" },
	},

	keys = {
		-- {
		-- 	"g?",
		-- 	function()
		-- 		require("which-key").show({ global = true })
		-- 	end,
		-- 	desc = "Buffer Local Keymaps (which-key)",
		-- },
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
