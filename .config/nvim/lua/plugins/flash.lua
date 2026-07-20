return {
	"folke/flash.nvim",
	event = "VeryLazy",
	priority = 1001,
	---@type Flash.Config
	opts = {
		jump = { autojump = true },
	},
	keys = {
		{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash", },
		{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
		{
			"R",
            { "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		-- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	},
}
