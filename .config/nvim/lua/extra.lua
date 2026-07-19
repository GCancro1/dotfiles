-- Extra keymaps & settings
-- Review before sourcing in init.lua

local map = vim.keymap.set

-- Window navigation (Ctrl+hjkl)
map("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })

-- Resize windows with arrows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Better indenting in visual mode (stays selected)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })
map("v", "<Tab>", ">gv", { desc = "Indent right" })
map("v", "<S-Tab>", "<gv", { desc = "Indent left" })

-- Terminal escape
map("t", "<C-Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Join lines without losing cursor
map("n", "J", "mzJ`z", { desc = "Join lines" })

-- Center after search navigation
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })

-- Undo/redo centering
map("n", "U", "<C-r>", { desc = "Redo" })

-- Select all
map("n", "<leader>sa", "ggVG", { desc = "Select all" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Better paste (don't yank replaced text)
map("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Yank to end of line (like D/C)
map("n", "Y", "y$", { desc = "Yank to end of line" })
