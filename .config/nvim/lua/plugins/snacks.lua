return{
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        picker = {
            enabled = true,
            layout = {preset = "telescope", layout = {height = .99, width = .99}},
        },

        bigfile = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        notify = { enabled = true, },
        quickfile = { enabled = true },
        scope = { enabled = true },
        statuscolumn = { enabled = false },
        words = { enabled = true },
    },
    keys = {
        { "<leader>a", function() Snacks.picker.smart() end, desc = "Find Files", },
        { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep", },
        { "<leader>sh", function() Snacks.picker.recent() end, desc = "Recent Files", },
        { "<leader>s<leader>", function() Snacks.picker.buffers() end, desc = "Buffers", },
        { "<leader>sf", function() Snacks.picker.files({ hidden = true, ignored = true, }) end, desc = "All Files", },
        { "<leader>n",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
        { "<leader>mh",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
        { "<leader>q", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        { "<leader>cr", function() Snacks.rename.rename_file() end, desc = "Rename File" },
        { "<leader>gw", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },

    },
} 
