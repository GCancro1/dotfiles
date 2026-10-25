return {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            styles = {
                comments = { italic = false },
            },
        })
        vim.cmd.colorscheme("tokyonight-night")
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#ffffff" })
    end,
}
