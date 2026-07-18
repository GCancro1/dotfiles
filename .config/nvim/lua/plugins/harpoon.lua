return {
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():add()
			end, { desc = "harpoon add" })
			vim.keymap.set("n", "<leader>hl", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())

             -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end)
            vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end)

			end, { desc = "harpoon menu" })
			vim.keymap.set("n", "<leader>1", function()
				harpoon:list():select(1)
			end, { desc = "Harpoon f1" })
			vim.keymap.set("n", "<leader>2", function()
				harpoon:list():select(2)
			end, { desc = "Harpoon f1" })
			vim.keymap.set("n", "<leader>3", function()
				harpoon:list():select(3)
			end, { desc = "Harpoon f1" })
			vim.keymap.set("n", "<leader>4", function()
				harpoon:list():select(4)
			end, { desc = "Harpoon f1" })
			vim.keymap.set("n", "<leader>5", function()
				harpoon:list():select(5)
			end, { desc = "Harpoon f1" })
			vim.keymap.set("n", "<leader>6", function()
				harpoon:list():select(6)
			end, { desc = "Harpoon f1" })
			vim.keymap.set("n", "<leader>7", function()
				harpoon:list():select(7)
			end, { desc = "Harpoon f1" })
			vim.keymap.set("n", "<leader>8", function()
				harpoon:list():select(8)
			end, { desc = "Harpoon f1" })
		end,
	}
