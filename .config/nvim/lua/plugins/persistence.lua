return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {
		dir = vim.fn.stdpath("data") .. "/session/",
	},
	config = function(_, opts)
		require("persistence").setup(opts)

		vim.keymap.set("n", "<leader>Ss", function()
			require("persistence").load()
		end, { desc = "Restore session for current dir" })

		vim.keymap.set("n", "<leader>SS", function()
			require("persistence").select()
		end, { desc = "Select session to load" })

		vim.keymap.set("n", "<leader>Sl", function()
			require("persistence").load({ last = true })
		end, { desc = "Restore last session" })

		vim.keymap.set("n", "<leader>Sd", function()
			require("persistence").stop()
		end, { desc = "Stop session persistence" })
	end,
}
