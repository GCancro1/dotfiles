-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Set the leader key to spacebar
vim.g.mapleader = " "

-- Basic clipboard integration (use system clipboard)
vim.opt.clipboard = 'unnamedplus'

-- Basic key mapping to save file
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':bd<CR>')

vim.keymap.set('n', '<leader>lv', ':so ~/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<leader>ll', ':.lua<CR>')
vim.keymap.set('v', '<leader>l', ":lua<CR>")



vim.keymap.set('n', '<Tab>', ':bn<CR>')
vim.keymap.set('n', '<S-Tab>', ':bp<CR>')

vim.keymap.set('n', '<leader>hh', ':e ~/.config/hypr/hyprland.lua<CR>')


require("oldbinds")

require("vimport")

require("biglazy")





-- print("loaded init.lua and all modules success")

