vim.keymap.set("n", "<leader>rs", function()
	vim.cmd("write")
	vim.cmd("RustRun")
end, { desc = "Run current Rust file" })

-- FIXME turn off diagnostics for now
vim.diagnostic.config({ underline = false })
vim.diagnostic.enable(false )
