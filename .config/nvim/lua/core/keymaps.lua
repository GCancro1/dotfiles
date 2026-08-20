-- Keymaps
-- Consolidated from init.lua + oldbinds.lua + vimport.lua (legacy files no longer loaded)
-- NOTE: c/C are NOT remapped here — the legacy "_c/"_C maps that broke ciw/ci" are gone.

local map = vim.keymap.set

-- ================= Normal — core =================
map("n", "<leader>w", ":w<CR>")
map("n", "<leader>q", ":bd<CR>")
map("n", "<leader>c", ":close!<CR>") -- winner; vimport's <leader>c='c' dropped
map("n", "<leader>z", ":q!<CR>")
map("n", "<leader>o", "<C-^>") -- alternate buffer
map("n", "<leader>lv", ":so ~/.config/nvim/init.lua<CR>") -- winner; legacy <leader>ls x2 dropped
map("n", "<leader>ll", ":.lua<CR>")
map("v", "<leader>l", ":lua<CR>")
map("i", "<C-BS>", "<C-W>")
map("n", "<leader>fi", "mz<cmd>normal! gg=G<CR>`z", { desc = "Indent entire file" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>") -- ⚠️ intentional: Esc clears search highlight
map("n", "<C-c>", "<cmd>nohlsearch<CR><Esc>", { noremap = true }) -- ⚠️ intentional

-- ================= Normal — black-hole delete =================
-- ⚠️ intentional: d/D always delete to the black hole register; use <leader>d/D to cut (save to register)
map("n", "d", '"_d', { noremap = true })
map("v", "d", '"_d', { noremap = true })
map("v", "D", '"_D', { noremap = true })
map("n", "<leader>D", "D", { noremap = true, desc = "Cut (save to register)" })
map("n", "<leader>d", "d", { noremap = true, desc = "Cut (save to register)" })
map("v", "<leader>d", "d", { noremap = true, desc = "Cut (save to register)" })

-- ================= Window & layout =================
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
map("n", "<Leader>H", "5<C-w><", { desc = "Narrower x5" })
map("n", "<Leader>K", "5<C-w>-", { desc = "Shorter x5" })
map("n", "<Leader>J", "5<C-w>+", { desc = "Taller x5" })
-- <Leader>L (wider x5) sacrificed: conflicts with <leader>L = newline above, which wins
map("n", "<leader>=", "<C-w>=", { desc = "Equalize windows" })
map("n", "<leader>ml", "99<C-w>h", { desc = "Focus left" })
map("n", "<leader>mr", "99<C-w>l", { desc = "Focus right" })
map("n", "<A-Left>", "<C-W><C-H>")
map("n", "<A-Right>", "<C-W><C-L>")
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move left from terminal" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move bottom from terminal" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move top from terminal" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move right from terminal" })

-- ================= Editing helpers =================
map("v", ".", ":norm .<CR>", { noremap = true }) -- ⚠️ intentional: repeat last change over selection
map("n", "<A-j>", ":m.+1<CR>==", { noremap = true })
map("n", "<A-k>", ":m.-2<CR>==", { noremap = true })
map("i", "<A-j>", "<Esc>:m.+1<CR>==gi", { noremap = true })
map("i", "<A-k>", "<Esc>:m.-2<CR>==gi", { noremap = true })
map("v", "<S-Down>", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Move selection down" })
map("v", "<S-Up>", ":m '<-2<CR>gv=gv", { noremap = true, desc = "Move selection up" })
map("n", "<S-Down>", ":m.+1<CR>==", { noremap = true, desc = "Move line down" })
map("n", "<S-Up>", ":m.-2<CR>==", { noremap = true, desc = "Move line up" })
map("i", "<S-Down>", "<Esc>:m.+1<CR>==gi", { noremap = true, desc = "Move line down" })
map("i", "<S-Up>", "<Esc>:m.-2<CR>==gi", { noremap = true, desc = "Move line up" })
-- ⚠️ intentional: operator-pending l/h = $/^ (overrides default; ch/cl/dh/dl semantics change)
map("o", "l", "$", { desc = "Operator pending: l → $" })
map("o", "h", "^", { desc = "Operator pending: h → ^" })
-- ⚠️ intentional: gh/gl = ^/$ (shadows builtin gh/gl line-display in n/v/o)
map("n", "gh", "^", { desc = "Start of line" })
map("n", "gl", "$", { desc = "End of line" })
map("v", "gh", "^", { desc = "Start of line (visual)" })
map("v", "gl", "$", { desc = "End of line (visual)" })
map("o", "gh", "^", { desc = "Start of line (operator)" })
map("o", "gl", "$", { desc = "End of line (operator)" })
map("n", "<C-d>", "<C-d>zz", { noremap = true })
map("n", "<C-u>", "<C-u>zz", { noremap = true })
map("n", "n", "nzzzv", { noremap = true })
map("n", "N", "Nzzzv", { noremap = true })
map("n", "<leader>l", "mzo<Esc>`z", { desc = "newline below" })
map("n", "<leader>L", "mzO<Esc>`z", { desc = "newline above" })
map("n", "<C-q>", "<C-v>", { desc = "Visual block mode" })
map({ "i", "c" }, "<C-Q>", "<C-V>", { noremap = true, silent = true })

-- Interactive replace (word under cursor / visual selection)
map("v", "<leader>r", function()
    vim.cmd('normal! "zy')
    local from = vim.fn.getreg("z")
    local to = vim.fn.input('Replace "' .. from .. '" with: ')
    if to == "" then
        return
    end
    vim.cmd(":%s/" .. vim.fn.escape(from, "/\\") .. "/" .. vim.fn.escape(to, "/\\") .. "/gc")
end, { silent = true, noremap = true })

map("n", "<leader>r", function()
    local from = vim.fn.expand("<cword>")
    local to = vim.fn.input('Replace "' .. from .. '" with: ')
    if to == "" then
        return
    end
    vim.cmd(":%s/" .. vim.fn.escape(from, "/\\") .. "/" .. vim.fn.escape(to, "/\\") .. "/gc")
end, { desc = "Substitute word under cursor (confirm)" })

-- Python print macro (normal: yank word, print line below; visual: yank selection as name)
map(
    "n",
    "<leader>,p",
    "yiwo"
    .. 'print(f"'
    .. '<C-r>"'
    .. " = {"
    .. '<C-r>"'
    .. '}")'
    .. "<Esc>",
    { noremap = true, silent = true }
)
map(
    "v",
    "<leader>,p",
    "y"
    .. "o"
    .. 'print(f"'
    .. '<C-r>"'
    .. " = {"
    .. '<C-r>"'
    .. '}")'
    .. "<Esc>",
    { noremap = true, silent = true }
)
map("n", "<leader>cr", ":%d+<CR>", { desc = "Delete all (to register)" })

-- ================= Yank / clipboard =================
map("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>P", '"+P', { desc = "Paste from clipboard" })
map("v", "<leader>P", '"+P', { desc = "Paste from clipboard" })
map("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
map("v", "<leader>p", '"+p', { desc = "Paste from clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })
map("n", "<leader>cd", "<cmd>%+d<CR>", { desc = "Del all of file" })
map("n", "<leader>ca", "<cmd>%+y<CR>", { desc = "Copy all of file" })
map("v", "p", '"_dP', { noremap = true })
map("n", "<leader>fp", function()
    vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy file path" })
map("n", "<leader>fd", function()
    vim.fn.setreg("+", vim.fn.expand("%:p:h"))
end, { desc = "Copy file dir" })

-- Textobject-yank namespace
map("n", "<leader>,'", "vi'pgv\"+y", { desc = "Paste without losing reg quotes" })
map("n", '<leader>,"', 'vi"pgv"+y', { desc = "Paste without losing reg quotes" })
map("n", "<leader>,[", 'vi]pgv"+y', { desc = "Paste without losing reg brackets" })
map("n", "<leader>,{", 'vi}pgv"+y', { desc = "Paste without losing reg braces" })
map("n", "<leader>,b", 'vibpgv"+y', { desc = "Paste without losing reg parens" })
map("n", "<leader>,a", "mz%a,<Esc>`z", { desc = "add comma to end of bracket" })


-- ================= Buffers / files =================
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprev<CR>", { desc = "Prev buffer" })
map("n", "<leader>n", "<cmd>enew<CR>", { desc = "New buffer" })
map("n", "<leader>vn", "<cmd>new<CR>", { desc = "New horizontal split" })
map("n", "<leader>vs", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "gb", ":bn<CR>", { desc = "Next Buf" })
map("n", "gB", ":bp<CR>", { desc = "Prev Buf" })
map("n", "<leader>sw", "<cmd>set wrap!<CR>", { desc = "Toggle wrap" })

-- ================= Diagnostics / quickfix =================
map("n", "gK", vim.diagnostic.open_float, { desc = "Diagnostic float" })
map("n", "]q", vim.cmd.cnext, { desc = "Quickfix: next item" })
map("n", "[q", vim.cmd.cprev, { desc = "Quickfix: prev item" })
map("n", "]Q", vim.cmd.cnfile, { desc = "Quickfix: next file" })
map("n", "[Q", vim.cmd.cpfile, { desc = "Quickfix: prev file" })
map("n", "<leader>co", "<cmd>copen<CR>", { desc = "Quickfix open" })
map("n", "<leader>cc", "<cmd>cclose<CR>", { desc = "Quickfix close" })
map("n", "<leader>cn", "<cmd>cnext<CR>zz", { desc = "Quickfix next" })
map("n", "<leader>cp", "<cmd>cprev<CR>zz", { desc = "Quickfix prev" })
map("n", "<leader>cf", "<cmd>cfirst<CR>zz", { desc = "Quickfix first" })
map("n", "<leader>cl", "<cmd>clast<CR>zz", { desc = "Quickfix last" })
map("n", "<leader>cw", "<cmd>cwindow<CR>", { desc = "Quickfix window" })
map("n", "<leader>cO", "<cmd>colder<CR>", { desc = "Quickfix older list" })
map("n", "<leader>cN", "<cmd>cnewer<CR>", { desc = "Quickfix newer list" })
