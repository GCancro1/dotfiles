return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash", "c", "diff", "lua",
                "luadoc", "markdown", "markdown_inline", "python", "query",
                "vim", "vimdoc", "yaml",
            },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<BS>",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = { query = "@function.outer", desc = "outer function" },
                        ["if"] = { query = "@function.inner", desc = "inner function" },
                        ["ac"] = { query = "@class.outer", desc = "outer class" },
                        ["ic"] = { query = "@class.inner", desc = "inner class" },
                        ["al"] = { query = "@loop.outer", desc = "outer loop" },
                        ["il"] = { query = "@loop.inner", desc = "inner loop" },
                        ["ai"] = { query = "@conditional.outer", desc = "outer conditional" },
                        ["ii"] = { query = "@conditional.inner", desc = "inner conditional" },
                        ["aa"] = { query = "@parameter.outer", desc = "outer argument" },
                        ["ia"] = { query = "@parameter.inner", desc = "inner argument" },
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]f"] = { query = "@function.outer", desc = "next function" },
                        ["]C"] = { query = "@class.outer", desc = "next class" },
                        ["]l"] = { query = "@loop.outer", desc = "next loop" },
                    },
                    goto_next_end = {
                        ["]F"] = { query = "@function.outer", desc = "end of next function" },
                        ["]<C-c>"] = { query = "@class.outer", desc = "end of next class" },
                    },
                    goto_previous_start = {
                        ["[f"] = { query = "@function.outer", desc = "prev function" },
                        ["[C"] = { query = "@class.outer", desc = "prev class" },
                        ["[l"] = { query = "@loop.outer", desc = "prev loop" },
                    },
                    goto_previous_end = {
                        ["[F"] = { query = "@function.outer", desc = "end of prev function" },
                        ["[<C-c>"] = { query = "@class.outer", desc = "end of prev class" },
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>xp"] =  {query = "@parameter.inner", desc = "swap next parameter" },
                    },
                    swap_previous = {
                        ["<leader>xP"] = { query = "@parameter.inner", desc = "swap prev parameter" },
                    },
                },
            },
        })
    end,
}
