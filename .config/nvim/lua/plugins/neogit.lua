return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
    },
    cmd = "Neogit",
    keys = {
        { "<leader>ge", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
    config = function()
        require("neogit").setup({
            integrations = {
                diffview = true,
            },
        })
    end,
}
