return {

	{
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
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
		config = function()
			require("treesj").setup({--[[ your config ]]
				vim.keymap.set("n", "<leader>x", function()
					require("treesj").toggle({ split = { recursive = true } })
				end),
			})
		end,
	},
	-- "kevinhwang91/nvim-ufo",
	-- "Wansmer/treesj",
	-- "MagicDuck/grug-far.nvim",
	-- "kevinhwang91/nvim-bqf",
	-- Vim unimpaired
	-- nmap <CR> o<Esc>k
	-- https://github.com/chentoast/marks.nvim
	-- https://github.com/cbochs/portal.nvim
	-- https://github.com/tomasky/bookmarks.nvim
	-- https://github.com/2KAbhishek/seeker.nvim

	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {},
	},

	-- {
	-- 	"2kabhishek/seeker.nvim",
	-- 	dependencies = { "folke/snacks.nvim" },
	-- 	cmd = { "Seeker" },
	-- 	-- keys = {
	-- 	--     { '<leader>fa', ':Seeker files<CR>', desc = 'Seek Files' },
	-- 	--     { '<leader>ff', ':Seeker git_files<CR>', desc = 'Seek Git Files' },
	-- 	--     { '<leader>fg', ':Seeker grep<CR>', desc = 'Seek Grep' },
	-- 	--     { '<leader>fw', ':Seeker grep_word<CR>', mode = { 'n', 'x' }, desc = 'Seek Grep Word' },
	-- 	-- },
	-- 	opts = {}, -- Required unless you call seeker.setup() manually, add your configs here
	--
	-- 	--     require('seeker').setup({
	-- 	--         picker_provider = 'snacks',    -- Picker provider: 'snacks' or 'telescope' (default: 'snacks')
	-- 	--         toggle_key = '<C-e>',          -- Key to toggle between modes (default)
	-- 	--         exclude_toggle_key = '<C-x>',  -- Key to toggle between modes excluding selected files (default)
	-- 	--         picker_opts = {},              -- Options passed to the picker provider (optional)
	-- 	--     })
	-- },
	--
	--
	-- NOTE - jump directly to item in lists... not super helpful
	-- {
	--     "cbochs/portal.nvim",
	--     -- Optional dependencies
	--     dependencies = {
	--         "cbochs/grapple.nvim",
	--         "ThePrimeagen/harpoon"
	--     },
	-- }
}
