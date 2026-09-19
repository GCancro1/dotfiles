return {
    "folke/which-key.nvim",
    event = "VeryLazy",

    delay = 0,
    opts = {
        spec = {
            { "<leader>s", group = "[S]earch", mode = { "n", "v" } },
            { "<leader>S", group = "[S]ession", mode = { "n", "v" } },
            { "<leader>c", group = "[C]quickfix", mode = { "n", "v" } },
            { "<leader>f", group = "[F]ile", mode = { "n", "v" } },
            { "<leader>t", group = "[T]oggle" },
            { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
            { "gr", group = "LSP Actions", mode = { "n" } },
        },
    },

    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
