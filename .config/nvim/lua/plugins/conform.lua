return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>ff",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = "",
            desc = "[F]ormat buffer",
        },
        {
            "<leader>ft",
            function()
                local bufnr = vim.api.nvim_get_current_buf()
                vim.b[bufnr].conform_format_on_save = not vim.b[bufnr].conform_format_on_save
                local state = vim.b[bufnr].conform_format_on_save and "ON" or "OFF"
                vim.notify("Format on save: " .. state)
            end,
            mode = "n",
            desc = "[T]oggle format on save (buffer)",
        },
    },
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            if not vim.b[bufnr].conform_format_on_save then
                return nil
            end
            local disable_filetypes = { c = true, cpp = true }
            if disable_filetypes[vim.bo[bufnr].filetype] then
                return nil
            end
            return {
                timeout_ms = 500,
                lsp_format = "fallback",
            }
        end,
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "ruff_format" },
        },
    },
}
