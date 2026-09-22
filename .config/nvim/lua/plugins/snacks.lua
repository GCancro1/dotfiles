return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		picker = {
			enabled = true,
			layout = { preset = "telescope", fullscreen = true },
			win = {
				input = {
					keys = {
						["<Space>"] = "type",
					},
				},
			},
		},

		bigfile = { enabled = true, line_length = 50000 },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		notify = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		statuscolumn = { enabled = false },
		words = { enabled = true },
	},
	keys = {
		{
			"<leader>a",
			function()
				Snacks.picker.smart()
			end,
			desc = "Find Files",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep({ hidden = true, ignored = true })
			end,
			desc = "Grep",
		},
		{
			"<leader>sn",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent Files",
		},
		{
			"<leader><leader>",
			function()
				Snacks.picker.buffers({
					win = {
						input = {
							keys = {
								["<c-z>"] = { "bufdelete", mode = { "n", "i" } },
							},
						},
					},
				})
			end,
			desc = "Buffers",
		},
		{
			"<leader>sf",
			function()
				Snacks.picker.files({ hidden = true, ignored = true })
			end,
			desc = "All Files",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>sl",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>se",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},
		{
			"<leader>sr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},
		{
			"<leader>s:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			'<leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<leader>s.",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<leader>.",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},

		{
			"<leader>mh",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
		{
			"<leader>q",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
		{
			"<leader>cr",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<leader>gw",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps({ plugs = true })
			end,
			desc = "keymap picker",
			mode = { "n" },
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},

		{
			"<leader>sH",
			function()
				Snacks.picker.help({
					previewers = {
						-- love.txt (1.1MB) and mini.nvim's docs (1.1MB) exceed the
						-- 1MB default max_size, so the file previewer showed
						-- "large file > 1MB" instead of the doc.
						file = { max_size = 10 * 1024 * 1024 },
					},
					confirm = function(picker, item)
						picker:close()
						if item and item.text then
							_G.help_no_split(item.text)
						end
					end,
				})
			end,
			desc = "Help Tags",
		},
	},
}
