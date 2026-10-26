vim.keymap.set("n", "<leader>rs", function()
	vim.cmd("write")
	vim.cmd("RustRun")
end, { desc = "Run current Rust file" })
