return {
    "simonwinther/opencode-tmux.nvim",
    name = "opencode-tmux",
    version = "*",
    keys = {
        {
            "<leader>oo",
            function()
                require("opencode-tmux").tmux_toggle()
            end,
            mode = { "n", "v" },
            desc = "Toggle OpenCode pane",
        },
        {
            "go",
            function()
                require("opencode-tmux").send()
            end,
            mode = { "n", "v" },
            desc = "Send selection/line to OpenCode",
        },
        {
            "<leader>ob",
            function()
                require("opencode-tmux").send_buffer()
            end,
            desc = "Send buffer to OpenCode",
        },
        {
            "<leader>oa",
            function()
                require("opencode-tmux").ask({ submit = true })
            end,
            mode = { "n", "v" },
            desc = "Ask OpenCode",
        },
        {
            "<leader>op",
            function()
                require("opencode-tmux").select_prompt()
            end,
            mode = { "n", "v" },
            desc = "Pick prompt (explain, review, fix...)",
        },
        {
            "<leader>os",
            function()
                require("opencode-tmux").submit_prompt()
            end,
            desc = "Submit OpenCode prompt",
        },
        {
            "<leader>oc",
            function()
                require("opencode-tmux").clear_prompt()
            end,
            desc = "Clear OpenCode prompt",
        },
    },
    config = function()
        require("opencode-tmux").setup({
            port = 4096,
            compact_context = false,
            code_fence = "backticks",
        })
    end,
}

-- PATCH: opencode-tmux cleanup kills the opencode pane on nvim exit.
-- To keep them independent, run after plugin updates:
--   bash ~/.config/nvim/patch-opencode-tmux.sh
