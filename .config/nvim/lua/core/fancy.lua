vim.keymap.set("n", "<leader>pr", "oprint(<C-r>+)", { desc = "Print register next line"})
vim.keymap.set("n", "<leader>pf", 'oprint("<C-r>+: " .. <C-r>+)', { desc = "Print register next line"})
vim.keymap.set("n", "<leader>pe", "oprint(", { desc = "Print register next line"})
vim.keymap.set("n", "<leader>pw", 'yiwoprint("<C-r>+:" .. <C-r>+)', { desc = "Print current word next line"})
vim.keymap.set("v", "<leader>pw", 'yoprint("<C-r>+:" .. <C-r>+)', { desc = "Print current word next line"})

vim.keymap.set("n", "gt", "g<", { desc = "open output term window" })

-- TODO  this would be cool to expand selection doesnt work
-- vim.keymap.set({"v"}, "m", "an", { desc = "select parent easier"})

-- vim.keymap.set("n", "<leader>td", "<cmd>diffoff<CR><cmd>only<CR>", { desc = "Toggle diff off" })
