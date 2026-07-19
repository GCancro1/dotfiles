return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
        { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    },
    config = function()
        require("nvim-treesitter").setup({})

        require("nvim-treesitter").install({
            "bash", "c", "diff", "html", "javascript", "json", "lua",
            "luadoc", "markdown", "markdown_inline", "python", "query",
            "toml", "tsx", "typescript", "vim", "vimdoc", "yaml",
        })

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        local select = require("nvim-treesitter-textobjects.select").select_textobject
        local move = require("nvim-treesitter-textobjects.move")

        require("nvim-treesitter-textobjects").setup({})

        local function map(mode, lhs, rhs, opts)
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Textobjects: select
        map({ "x", "o" }, "af", function() select("@function.outer", "textobjects") end, { desc = "outer function" })
        map({ "x", "o" }, "if", function() select("@function.inner", "textobjects") end, { desc = "inner function" })
        map({ "x", "o" }, "ac", function() select("@class.outer", "textobjects") end, { desc = "outer class" })
        map({ "x", "o" }, "ic", function() select("@class.inner", "textobjects") end, { desc = "inner class" })
        map({ "x", "o" }, "al", function() select("@loop.outer", "textobjects") end, { desc = "outer loop" })
        map({ "x", "o" }, "il", function() select("@loop.inner", "textobjects") end, { desc = "inner loop" })
        map({ "x", "o" }, "ai", function() select("@conditional.outer", "textobjects") end, { desc = "outer conditional" })
        map({ "x", "o" }, "ii", function() select("@conditional.inner", "textobjects") end, { desc = "inner conditional" })
        map({ "x", "o" }, "ap", function() select("@parameter.outer", "textobjects") end, { desc = "outer argument" })
        map({ "x", "o" }, "ip", function() select("@parameter.inner", "textobjects") end, { desc = "inner argument" })
        map({ "x", "o" }, "av", function() select("@variable.outer", "textobjects") end, { desc = "outer variable" })
        map({ "x", "o" }, "iv", function() select("@variable.inner", "textobjects") end, { desc = "inner variable" })

        -- Textobjects: move
        map({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "next function" })
        map({ "n", "x", "o" }, "]C", function() move.goto_next_start("@class.outer", "textobjects") end, { desc = "next class" })
        map({ "n", "x", "o" }, "]l", function() move.goto_next_start("@loop.outer", "textobjects") end, { desc = "next loop" })
        map({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer", "textobjects") end, { desc = "end of next function" })
        map({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "prev function" })
        map({ "n", "x", "o" }, "[C", function() move.goto_previous_start("@class.outer", "textobjects") end, { desc = "prev class" })
        map({ "n", "x", "o" }, "[l", function() move.goto_previous_start("@loop.outer", "textobjects") end, { desc = "prev loop" })
        map({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer", "textobjects") end, { desc = "end of prev function" })

        -- Textobjects: swap
        local swap = require("nvim-treesitter-textobjects.swap")
        map("n", "<leader>xp", function() swap.swap_next("@parameter.inner") end, { desc = "swap next parameter" })
        map("n", "<leader>xP", function() swap.swap_previous("@parameter.inner") end, { desc = "swap prev parameter" })

        -- Repeatable moves with ; and ,
        local ts_repeat = require("nvim-treesitter-textobjects.repeatable_move")
        map({ "n", "x", "o" }, ";", ts_repeat.repeat_last_move_next)
        map({ "n", "x", "o" }, ",", ts_repeat.repeat_last_move_previous)
        map({ "n", "x", "o" }, "f", ts_repeat.builtin_f_expr, { expr = true })
        map({ "n", "x", "o" }, "F", ts_repeat.builtin_F_expr, { expr = true })
        map({ "n", "x", "o" }, "t", ts_repeat.builtin_t_expr, { expr = true })
        map({ "n", "x", "o" }, "T", ts_repeat.builtin_T_expr, { expr = true })
    end,
}
