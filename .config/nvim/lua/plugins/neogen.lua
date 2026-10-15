return {
	"danymat/neogen",
	-- Uncomment next line if you want to follow only stable versions
	-- version = "*"
	configuration = {
		-- Enables Neogen capabilities
		enabled = true,

		-- Go to annotation after insertion, and change to insert mode
		input_after_comment = true,

		-- Configuration for default languages
		languages = { lua = {}, python = {} },

		-- Use a snippet engine to generate annotations.
		snippet_engine = "luasnip",

		-- Enables placeholders when inserting annotation
		enable_placeholders = true,

		-- Placeholders used during annotation expansion
		placeholders_text = {
			["description"] = "[TOD:description]",
			["tparam"] = "[TOD:tparam]",
			["parameter"] = "[TOD:parameter]",
			["return"] = "[TOD:return]",
			["class"] = "[TOD:class]",
			["throw"] = "[TOD:throw]",
			["varargs"] = "[TOD:varargs]",
			["type"] = "[TOD:type]",
			["attribute"] = "[TOD:attribute]",
			["args"] = "[TOD:args]",
			["kwargs"] = "[TOD:kwargs]",
		},

		-- Placeholders highlights to use. If you don't want custom highlight, pass "None"
		placeholders_hl = "DiagnosticHint",
	},
	config = function()
		local neogen = require("neogen")

		local ls = require("luasnip")
		neogen.setup({
			snippet_engine = "luasnip",
		})

		vim.keymap.set("n", "<leader>gl", function()
			neogen.generate({ type = "file" })
		end, { desc = "Neogen file" })

		vim.keymap.set("n", "<leader>gc", function()
			neogen.generate({ type = "class" })
		end, { desc = "Neogen class" })

		vim.keymap.set("n", "<leader>gf", function()
			neogen.generate({ type = "func" })
		end, { desc = "Neogen func" })

		vim.keymap.set("n", "<leader>gt", function()
			neogen.generate({ type = "type" })
		end, { desc = "Neogen type" })
		vim.keymap.set({ "i", "s" }, "<C-g>", function()
			if ls.jumpable(1) then
				ls.jump(1)
			else
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-g>", true, false, true), "i", false)
			end
		end)

		vim.keymap.set({ "i", "s" }, "<C-t>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			else
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-t>", true, false, true), "i", false)
			end
		end)
	end,
}
