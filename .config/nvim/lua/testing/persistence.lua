return {
	"folke/persistence.nvim",
    lazy = false,
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

		-- Auto-save session on exit
		vim.api.nvim_create_autocmd("VimLeavePre", {
			group = vim.api.nvim_create_augroup("session_autosave", { clear = true }),
			callback = function()
				require("persistence").save()
			end,
		})

		-- Auto-restore session when opening nvim with no arguments
		vim.api.nvim_create_autocmd("VimEnter", {
			group = vim.api.nvim_create_augroup("session_autorestore", { clear = true }),
			callback = function()
				if vim.fn.argc() == 0 then
					require("persistence").load()
					-- Reload buffers after session restore to re-attach treesitter/LSP
					vim.defer_fn(function()
						for _, buf in ipairs(vim.api.nvim_list_bufs()) do
							if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) ~= "" and not vim.bo[buf].modified then
								vim.api.nvim_buf_call(buf, function()
									vim.cmd("silent! e!")
								end)
							end
						end
					end, 100)
				end
			end,
		})
	end,
}
