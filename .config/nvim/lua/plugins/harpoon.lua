return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        local harpoon_idx = 0

        vim.keymap.set("n", "<leader>ha", function()
            harpoon:list():add()
        end, { desc = "Harpoon add" })
        vim.keymap.set("n", "<leader>hl", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon menu" })
        vim.keymap.set("n", "<leader>hn", function()
            local list = harpoon:list()
            if #list.items == 0 then return end
            harpoon_idx = harpoon_idx % #list.items + 1
            list:select(harpoon_idx)
        end, { desc = "Harpoon next" })
        vim.keymap.set("n", "<leader>hp", function()
            local list = harpoon:list()
            if #list.items == 0 then return end
            harpoon_idx = (harpoon_idx - 2 + #list.items) % #list.items + 1
            list:select(harpoon_idx)
        end, { desc = "Harpoon prev" })
        vim.keymap.set("n", "<leader>1", function()
            harpoon:list():select(1)
        end, { desc = "Harpoon f1" })
        vim.keymap.set("n", "<leader>2", function()
            harpoon:list():select(2)
        end, { desc = "Harpoon f2" })
        vim.keymap.set("n", "<leader>3", function()
            harpoon:list():select(3)
        end, { desc = "Harpoon f3" })
        vim.keymap.set("n", "<leader>4", function()
            harpoon:list():select(4)
        end, { desc = "Harpoon f4" })
        vim.keymap.set("n", "<leader>5", function()
            harpoon:list():select(5)
        end, { desc = "Harpoon f5" })
        vim.keymap.set("n", "<leader>6", function()
            harpoon:list():select(6)
        end, { desc = "Harpoon f6" })
        vim.keymap.set("n", "<leader>7", function()
            harpoon:list():select(7)
        end, { desc = "Harpoon f7" })
        vim.keymap.set("n", "<leader>8", function()
            harpoon:list():select(8)
        end, { desc = "Harpoon f8" })
    end,
}
