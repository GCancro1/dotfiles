-- Textobjects: select
vim.keymap.set({ "x", "o" }, "af", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end, { desc = "outer function" })
vim.keymap.set({ "x", "o" }, "if", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end, { desc = "inner function" })
vim.keymap.set({ "x", "o" }, "ac", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end, { desc = "outer class" })
vim.keymap.set({ "x", "o" }, "ic", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end, { desc = "inner class" })
vim.keymap.set({ "x", "o" }, "al", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer", "textobjects")
end, { desc = "outer loop" })
vim.keymap.set({ "x", "o" }, "il", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner", "textobjects")
end, { desc = "inner loop" })
vim.keymap.set({ "x", "o" }, "ai", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer", "textobjects")
end, { desc = "outer conditional" })
vim.keymap.set({ "x", "o" }, "ii", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner", "textobjects")
end, { desc = "inner conditional" })
vim.keymap.set({ "x", "o" }, "aP", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
end, { desc = "outer argument" })
vim.keymap.set({ "x", "o" }, "iP", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
end, { desc = "inner argument" })
vim.keymap.set({ "x", "o" }, "av", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@variable.outer", "textobjects")
end, { desc = "outer variable" })
vim.keymap.set({ "x", "o" }, "iv", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@variable.inner", "textobjects")
end, { desc = "inner variable" })

-- Textobjects: move
vim.keymap.set({ "n", "x", "o" }, "]f", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end, { desc = "next function" })
vim.keymap.set({ "n", "x", "o" }, "]C", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end, { desc = "next class" })
vim.keymap.set({ "n", "x", "o" }, "]l", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@loop.outer", "textobjects")
end, { desc = "next loop" })
vim.keymap.set({ "n", "x", "o" }, "]F", function()
	require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
end, { desc = "end of next function" })
vim.keymap.set({ "n", "x", "o" }, "[f", function()
	require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end, { desc = "prev function" })
vim.keymap.set({ "n", "x", "o" }, "[C", function()
	require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end, { desc = "prev class" })
vim.keymap.set({ "n", "x", "o" }, "[l", function()
	require("nvim-treesitter-textobjects.move").goto_previous_start("@loop.outer", "textobjects")
end, { desc = "prev loop" })
vim.keymap.set({ "n", "x", "o" }, "[F", function()
	require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
end, { desc = "end of prev function" })

-- Textobjects: swap leader>x a/p for forward, P/A/b for back
vim.keymap.set("n", "<leader>xa", function()
	require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
end, { desc = "swap next parameter" })
vim.keymap.set("n", "<leader>xb", function()
	require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
end, { desc = "swap prev parameter" })
vim.keymap.set("n", "<leader>xA", function()
	require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
end, { desc = "swap prev parameter" })
vim.keymap.set("n", "<leader>xp", function()
	require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
end, { desc = "swap next parameter" })
vim.keymap.set("n", "<leader>xP", function()
	require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
end, { desc = "swap prev parameter" })

-- Repeatable moves with ; and FIXME TODO,
-- vim.keymap.set({ "n", "x", "o" }, ";", require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move_next)
-- vim.keymap.set({ "n", "x", "o" }, ",", require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move_previous)
-- vim.keymap.set(
-- 	{ "n", "x", "o" },
-- 	"f",
-- 	require("nvim-treesitter-textobjects.repeatable_move").builtin_f_expr,
-- 	{ expr = true }
-- )
-- vim.keymap.set(
-- 	{ "n", "x", "o" },
-- 	"F",
-- 	require("nvim-treesitter-textobjects.repeatable_move").builtin_F_expr,
-- 	{ expr = true }
-- )
-- vim.keymap.set(
-- 	{ "n", "x", "o" },
-- 	"t",
-- 	require("nvim-treesitter-textobjects.repeatable_move").builtin_t_expr,
-- 	{ expr = true }
-- )
-- vim.keymap.set(
-- 	{ "n", "x", "o" },
-- 	"T",
-- 	require("nvim-treesitter-textobjects.repeatable_move").builtin_T_expr,
-- 	{ expr = true }
-- )
