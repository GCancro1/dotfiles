-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = "unnamedplus"


require("oldbinds")
require("vimport")


-- Keymaps
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":bd<CR>")
vim.keymap.set("n", "<leader>c", ":close!<CR>")
vim.keymap.set("n", "<leader>z", ":q!<CR>")
vim.keymap.set("n", "<leader>lv", ":so ~/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>ll", ":.lua<CR>")
vim.keymap.set("v", "<leader>l", ":lua<CR>")

-- go to last file
vim.keymap.set("n", "<leader>o", "<C-^>")
-- Treesitter folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Indent entire file
vim.keymap.set("n", "<leader>fi", "mz<cmd>normal! gg=G<CR>`z", { desc = "Indent entire file" })

-- Open help in current window (no split)
_G.help_no_split = function(topic)
    if not topic or topic == "" then
        vim.cmd("help")
        return
    end
    vim.cmd("help " .. topic)
    local help_win = vim.api.nvim_get_current_win()
    local help_buf = vim.api.nvim_win_get_buf(help_win)
    vim.cmd("wincmd p")
    local orig_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(orig_win, help_buf)
    vim.api.nvim_win_close(help_win, true)
    vim.api.nvim_set_current_win(orig_win)
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. out)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "plugins" },
})
