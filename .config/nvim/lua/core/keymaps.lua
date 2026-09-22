-- Keymaps

-- TODO move me


-- ================= Normal — core =================
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":bd<CR>")
vim.keymap.set("n", "<leader>qw", ":close!<CR>")
vim.keymap.set("n", "<leader>qa", ":q!<CR>")
vim.keymap.set("n", "<leader>o", "<C-^>", {desc = "alternate buf"}) -- alternate buffer

vim.keymap.set("n", "<leader>ll", ":.lua<CR>")
vim.keymap.set("n", "<leader>lf", ":! lua %<CR>")
vim.keymap.set("v", "<leader>l", ":lua<CR>")

vim.keymap.set("i", "<C-BS>", "<C-W>")
vim.keymap.set("i", "<C-Del>", "<C-O>dw")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- ================= Window & layout =================
vim.keymap.set("n", "<S-Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<S-Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<S-Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<S-Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<leader>=", "<C-w>=", { desc = "Equalize windows" })
-- TODO this feels weird
vim.keymap.set("n", "<A-S-Left>", "5<C-w><", { desc = "Narrower x5" })
vim.keymap.set("n", "<A-S-Down>", "5<C-w>-", { desc = "Shorter x5" })
vim.keymap.set("n", "<A-S-Up>", "5<C-w>+", { desc = "Taller x5" })
vim.keymap.set("n", "<A-S-Right>", "5<C-w>>", { desc = "Wider x5" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<A-Left>", "<C-\\><C-n><C-w>h", { desc = "Move left from terminal" })
vim.keymap.set("t", "<A-Down>", "<C-\\><C-n><C-w>j", { desc = "Move bottom from terminal" })
vim.keymap.set("t", "<A-Up>", "<C-\\><C-n><C-w>k", { desc = "Move top from terminal" })
vim.keymap.set("t", "<A-Right>", "<C-\\><C-n><C-w>l", { desc = "Move right from terminal" })

-- ================= Editing helpers =================
vim.keymap.set("v", ".", ":norm .<CR>", { noremap = true }) -- ⚠️ intentional: repeat last change over selection
vim.keymap.set("n", "<A-Up>", ":m.-2<CR>==", { noremap = true })
vim.keymap.set("i", "<A-Down>", "<Esc>:m.+1<CR>==gi", { noremap = true })
vim.keymap.set("n", "<A-Down>", ":m.+1<CR>==", { noremap = true })
vim.keymap.set("i", "<A-Up>", "<Esc>:m.-2<CR>==gi", { noremap = true })

-- ⚠️ intentional: operator-pending l/h = $/^ (overrides default; ch/cl/dh/dl semantics change)
-- vim.keymap.set("o", "l", "$", { desc = "Operator pending: l → $" })
-- vim.keymap.set("o", "h", "^", { desc = "Operator pending: h → ^" })

-- switchign from gl and gh to arrow keys
vim.keymap.set("o", "<Right>", "$", { desc = "Operator pending: → → end of line" })
vim.keymap.set("o", "<Left>", "^", { desc = "Operator pending: ← → start of line" })
vim.keymap.set("o", "<Up>", "gg", { desc = "Operator pending: ↑ → start of file" })
vim.keymap.set("o", "<Down>", "G", { desc = "Operator pending: ↓ → end of file" })
vim.keymap.set("n", "g<Left>", "^", { desc = "Start of line" })
vim.keymap.set("n", "g<Right>", "$", { desc = "End of line" })
vim.keymap.set("v", "g<Left>", "^", { desc = "Start of line (visual)" })
vim.keymap.set("v", "g<Right>", "$", { desc = "End of line (visual)" })
vim.keymap.set("o", "g<Left>", "^", { desc = "Start of line (operator)" })
vim.keymap.set("o", "g<Right>", "$", { desc = "End of line (operator)" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })

vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })

vim.keymap.set("n", "<leader>l", "mzo<Esc>`z", { desc = "newline below" })
vim.keymap.set("n", "<leader>L", "mzO<Esc>`z", { desc = "newline above" })

vim.keymap.set("n", "<C-k>", "<C-v>", { desc = "Visual block mode" })
vim.keymap.set({ "i", "c" }, "<C-k>", "<C-V>", { noremap = true, silent = true })

-- ================= Yank / clipboard =================
vim.keymap.set("n", "<leader>cd", 'gg"_dG', { desc = "Del all of file" })
vim.keymap.set("n", "<leader>ca", "<cmd>%+y<CR>", { desc = "Copy all of file" })
vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete to black-hole register" })

-- file operations 
vim.keymap.set("n", "<leader>fi", "mz<cmd>normal! gg=G<CR>`z", { desc = "Indent entire file" })
vim.keymap.set("n", "<leader>fp", function()
	vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy file path" })
vim.keymap.set("n", "<leader>fd", function()
	vim.fn.setreg("+", vim.fn.expand("%:p:h"))
end, { desc = "Copy file dir" })

-- Textobject-yank namespace
vim.keymap.set("n", "<leader>,a", "mz%a,<Esc>`z", { desc = "add comma to end of bracket" })

-- ================= Buffers / files =================
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprev<CR>", { desc = "Prev buffer" })
vim.keymap.set("n", "<leader>n", "<cmd>enew<CR>", { desc = "New buffer" })
vim.keymap.set("n", "<leader>vn", "<cmd>new<CR>", { desc = "New horizontal split" })
vim.keymap.set("n", "<leader>vs", "<cmd>vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>tw", "<cmd>set wrap!<CR>", { desc = "Toggle wrap" })

-- ================= Quickfix =================
-- Quickfix navigation
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Quickfix: next item", })
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Quickfix: previous item",
})

vim.keymap.set("n", "]Q", vim.cmd.cnfile, { desc = "Quickfix: next file", })
vim.keymap.set("n", "[Q", vim.cmd.cpfile, { desc = "Quickfix: previous file", })

-- Quickfix list
vim.keymap.set("n", "<leader>co", vim.cmd.copen, { desc = "Quickfix: open", })
vim.keymap.set("n", "<leader>cc", vim.cmd.cclose, { desc = "Quickfix: close", })
vim.keymap.set("n", "<leader>cw", vim.cmd.cwindow, { desc = "Quickfix: toggle window", })

-- Quickfix items
vim.keymap.set("n", "<leader>cn", function() vim.cmd.cnext() vim.cmd.normal({ "zz", bang = true }) end, { desc = "Quickfix: next item", })
vim.keymap.set("n", "<leader>cp", function() vim.cmd.cprev() vim.cmd.normal({ "zz", bang = true }) end, { desc = "Quickfix: previous item", })
vim.keymap.set("n", "<leader>cf", function() vim.cmd.cfirst() vim.cmd.normal({ "zz", bang = true }) end, { desc = "Quickfix: first item", })

vim.keymap.set("n", "<leader>cl", function() vim.cmd.clast() vim.cmd.normal({ "zz", bang = true }) end, { desc = "Quickfix: last item", })

vim.keymap.set("n", "<leader>ce", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
-- Quickfix list history
vim.keymap.set("n", "<leader>cO", vim.cmd.colder, { desc = "Quickfix: older list", })
vim.keymap.set("n", "<leader>cN", vim.cmd.cnewer, { desc = "Quickfix: newer list", })
