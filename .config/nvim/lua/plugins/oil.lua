return {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "echasnovski/mini.icons", "3rd/image.nvim" },
    keys = {
        { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
        { "<leader>fn", function()
            vim.ui.input({ prompt = "New file path: ", completion = "file" }, function(path)
                if path and path ~= "" then
                    local dir = vim.fn.fnamemodify(path, ":h")
                    if dir ~= "" and vim.fn.isdirectory(dir) == 0 then
                        vim.fn.mkdir(dir, "p")
                    end
                    vim.cmd("edit " .. path)
                end
            end)
        end, desc = "New file" },
    },

    config = function()
        require("oil").setup({
            default_file_explorer = true,
            keymaps = {
                ["q"] = "actions.close",
                ["<C-h>"] = false,
                ["<S-->"] = "actions.parent",
            },
            preview_win = {
                border = "rounded",
                -- image.nvim hijacks via BufWinEnter/WinNew pattern matching on the
                -- buffer name; scratch buffers are unnamed so they can never be
                -- hijacked. "load" keeps the file path as the buffer name so
                -- image.nvim's hijack autocmds match and render the image.
                preview_method = "load",
            },
            delete_to_trash = true,
            view_options = { show_hidden = false },
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "OilEnter",
            callback = vim.schedule_wrap(function(args)
                local oil = require("oil")
                if vim.api.nvim_get_current_buf() == args.data.buf then
                    vim.defer_fn(function()
                        if oil.get_cursor_entry() then
                            oil.open_preview()
                        end
                    end, 50)
                end
            end),
        })
    end,
}