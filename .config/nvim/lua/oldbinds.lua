vim.opt.runtimepath:append("/home/g/.local/share/nvim/site")

--der>ff Set Python provider (for Vimscript plugins that need Python)
local venv_path = "/home/g/venv/bin/python"
vim.g.python_host_prog = venv_path
vim.g.python3_host_prog = venv_path -- Python 3

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true
vim.o.mouse = "a"

vim.opt.textwidth = 0
-- vim.opt.formatoptions-=t

vim.opt.relativenumber = true -- editor.lineNumbers: "relative"
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.wrap = true       -- editor.wordWrap: "wordWrapColumn"
vim.opt.wrapmargin = 160  -- editor.wordWrapColumn: 160
vim.opt.termguicolors = true
vim.opt.scrolloff = 6     -- editor.cursorSurroundingLines: 6
vim.opt.hlsearch = true   -- vim.hlsearch: true
vim.opt.ignorecase = true -- vim.sneakUseIgnorecaseAndSmartcase: true
vim.opt.smartcase = true
vim.opt.updatetime = 100  -- vim.highlightedyank.duration equivalent

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.laststatus = 3
local map = vim.keymap.set

-- -- Sync clipboard between OS and Neovim.
-- --  Schedule the setting after `UiEnter` because it can increase startup-time.
-- --  Remove this option if you want your OS clipboard to remain independent.
-- --  See `:help 'clipboard'`
-- vim.schedule(function()
-- 	vim.o.clipboard = "unnamedplus"
-- end)
--
-- Enable break indent
vim.o.breakindent = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
-- vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 8

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- window movement
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<Leader>H", "5<C-w><", { desc = "Narrower x5" })
vim.keymap.set("n", "<Leader>L", "5<C-w>>", { desc = "Wider x5" })
vim.keymap.set("n", "<Leader>K", "5<C-w>-", { desc = "Shorter x5" })
vim.keymap.set("n", "<Leader>J", "5<C-w>+", { desc = "Taller x5" })

--
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move left from terminal" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move bottom from terminal" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move top from terminal" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move right from terminal" })
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- LSP bindings (your gd, gr, gi)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- Insert mode: jk → Esc + nohl
-- vim.keymap.set("i", "jj", "<Esc><cmd>nohlsearch<CR>l", { noremap = true })
-- vim.keymap.set("i", "jf", "<Esc><cmd>nohlsearch<CR>l", { noremap = true })
-- TODO remove me when stop esc out of insert mode
-- vim.keymap.set("i", "<Esc>", "<cmd>nohlsearch<CR> useJJ ", { noremap = true })

-- Search centering
vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })

vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste from clipboard" })
vim.keymap.set("v", "<leader>P", '"+P', { desc = "Paste from clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("n", "<leader>w", "<cmd>w!<CR>", { desc = "Force write" })

vim.keymap.set("o", "l", "$", { desc = "Operator pending: l → $" })
vim.keymap.set("o", "h", "^", { desc = "Operator pending: h → ^" })

-- Ctrl+q → Visual Block Mode (your VSCode Vim habit)
vim.keymap.set("n", "<C-q>", "<C-v>", { desc = "Visual block mode" })

vim.keymap.set("n", "<leader>q", ":bd<CR>")

vim.keymap.set("n", "<leader>d", [["_d]], { desc = "Delete to black hole" })
vim.keymap.set("v", "<leader>d", [["_d]], { desc = "Delete to black hole" })

-- TODO !!!
-- <leader>, = Text object yank namespace
-- vim.keymap.set("n", "<leader>,", "<Nop>", { desc = "Text objects" })

vim.keymap.set("n", "<leader>,'", "vi'pgv\"+y", { desc = "Paste without losing reg quotes" })
vim.keymap.set("n", '<leader>,"', 'vi"pgv"+y', { desc = "Paste without losing reg quotes" })
vim.keymap.set("n", "<leader>,[", 'vi]pgv"+y', { desc = "Paste without losing reg brackets" })
vim.keymap.set("n", "<leader>,{", 'vi}pgv"+y', { desc = "Paste without losing reg braces" })
vim.keymap.set("n", "<leader>,b", 'vibpgv"+y', { desc = "Paste without losing reg parens" })

vim.keymap.set("n", "<leader>,a", "mz%a,<Esc>`z", { desc = "add comma to end of bracket" })
-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Toggle explorer" })

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Shift visual selected line up
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Shift visual selected line down

vim.keymap.set("v", "<leader>r", function()
    vim.cmd('normal! "zy')
    local from = vim.fn.getreg("z")
    local to = vim.fn.input('Replace "' .. from .. '" with: ')
    if to == "" then
        return
    end
    vim.cmd(":%s/" .. vim.fn.escape(from, "/\\") .. "/" .. vim.fn.escape(to, "/\\") .. "/gc")
end, { silent = true, noremap = true })

-- same replace but in normal mode
vim.keymap.set("n", "<leader>r", function()
    local from = vim.fn.expand("<cword>")
    local to = vim.fn.input('Replace "' .. from .. '" with: ')
    if to == "" then
        return
    end
    vim.cmd(":%s/" .. vim.fn.escape(from, "/\\") .. "/" .. vim.fn.escape(to, "/\\") .. "/gc")
end, { desc = "Substitute word under cursor (confirm)" })

-- Normal mode
vim.keymap.set("n", "gh", "^", { desc = "Start of line" })
vim.keymap.set("n", "gl", "$", { desc = "End of line" })

-- Visual mode
vim.keymap.set("v", "gh", "^", { desc = "Start of line (visual)" })
vim.keymap.set("v", "gl", "$", { desc = "End of line (visual)" })

-- Operator-pending mode
vim.keymap.set("o", "gh", "^", { desc = "Start of line (operator)" })
vim.keymap.set("o", "gl", "$", { desc = "End of line (operator)" })

-- vim.keymap.set("n", "<leader>l", "<CMD>:w<CR><CMD>luafile %<CR>", { desc = "source lua" })
vim.keymap.set("n", "<leader>ls", "<CMD>luafile ~/.config/nvim/init.lua<CR>", { desc = "source lua" })

-- remaps for python printing
vim.keymap.set(
    "n",
    "<leader>,p",
    "yiwo" .. 'print(f"' .. '<C-r>"' .. " = {" .. '<C-r>"' .. '}")' .. "<Esc>",
    { noremap = true, silent = true }
)

-- Visual mode: use selected text as "variable name"
vim.keymap.set(
    "v",
    "<leader>,p",
    "y"       -- yank visual selection into "
    .. "o"    -- new line below
    .. 'print(f"'
    .. '<C-r>"' -- insert selection as name
    .. " = {"
    .. '<C-r>"' -- insert selection again in {}
    .. '}")'
    .. "<Esc>",
    { noremap = true, silent = true }
)

vim.keymap.set("n", "gK", vim.diagnostic.open_float, { desc = "Diagnostic float" })

vim.keymap.set("n", "<leader>l", "mzo<Esc>`z", { desc = "newline below" })
vim.keymap.set("n", "<leader>L", "mzO<Esc>`z", { desc = "newline above" })

vim.keymap.set("n", "gb", ":bn<CR>", { desc = "Next Buf" })

vim.keymap.set("n", "gB", ":bp<CR>", { desc = "Prev Buf" })

vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Quickfix: next item" })
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Quickfix: prev item" })
vim.keymap.set("n", "]Q", vim.cmd.cnfile, { desc = "Quickfix: next file" })
vim.keymap.set("n", "[Q", vim.cmd.cpfile, { desc = "Quickfix: prev file" })

-- Remap Ctrl-Q in insert mode to act like Ctrl-V (literal insert)
vim.keymap.set({ "i", "c" }, "<C-Q>", "<C-V>", { noremap = true, silent = true })

-- ====== LOAD PLUGINS ======

-- require("setuplazy") -- Your plugins/lazy/kickstart logic

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "qf",
-- 	callback = function()
-- 		vim.defer_fn(function()
-- 			-- Only proceed if this is a quickfix window
-- 			if vim.bo.filetype == "qf" and vim.bo.buftype == "quickfix" then
-- 				-- Close the original quickfix window
-- 				local qf_win_id = vim.fn.win_getid()
-- 				vim.cmd("Trouble quickfix")
-- 				-- Close the original window after a tiny delay to avoid race
-- 				vim.defer_fn(function()
-- 					pcall(vim.api.nvim_win_close, qf_win_id, true)
-- 				end, 5)
-- 			end
-- 		end, 10)
-- 	end,
-- })
-- -- Run python and load errors into quickfix automatically
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "python",
-- 	callback = function()
-- 		vim.bo.makeprg = "python3 %"
--
-- 		-- Simple Python traceback patterns
-- 		vim.opt.errorformat = "%f:%l:%c:%t:[%m]"
-- 		-- vim.bo.errorformat = 'File "%f", line %l%.%#,' .. "%Z%\\s*%m," .. "%C%\\s*%.%#"
-- 	end,
-- })
--

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "python",
-- 	callback = function()
-- 		vim.g.python3_host_prog = "/path/to/your/venv/bin/python"
-- 		vim.bo.makeprg = "python3 %"
-- 		vim.bo.errorformat = [[
--       %AFile\ \"%f\",\ line\ %l%.%#,
--       %Z%\\s*%m,
--       %C%\\s*%m,
--     ]]
-- 	end,
-- })
--
-- vim.keymap.set("n", "<F4>", function()
-- 	vim.cmd("make")
-- 	-- vim.cmd("Trouble quickfix")
-- 	vim.cmd("copen")
-- end, { desc = "Python: make → trouble" })
--
--
-- -- Run python3 %, extract file:line from traceback, populate quickfix
-- function RunPythonQuickfix()
-- 	-- Save first
-- 	vim.cmd("write")
--
-- 	-- Get full path of current file
-- 	local file = vim.fn.expand("%:p")
-- 	if not file:match("%.py$") then
-- 		vim.notify("Not a Python file", vim.log.levels.WARN)
-- 		return
-- 	end
--
-- 	-- Run python3 and capture all output
-- 	local cmd = string.format("python3 %s 2>&1", vim.fn.shellescape(file))
-- 	local output = vim.fn.systemlist(cmd)
--
-- 	-- If exit code != 0, process output
-- 	if vim.v.shell_error == 0 then
-- 		vim.notify("Python script ran successfully", vim.log.levels.INFO)
-- 	else
-- 		vim.notify("Python script failed", vim.log.levels.ERROR)
-- 	end
--
-- 	-- Build quickfix entries by parsing "File \"...\", line ..." lines
-- 	local qflist = {}
-- 	local in_traceback = false
--
-- 	for _, line in ipairs(output) do
-- 		-- Look for: File "path/to/file.py", line 123
-- 		local f, l = line:match('File%s+"([^"]+)",%s+line%s+(%d+)')
-- 		if f and l then
-- 			table.insert(qflist, {
-- 				filename = f,
-- 				lnum = tonumber(l),
-- 				text = line, -- e.g. "File \"file.py\", line 123, in <module>"
-- 			})
-- 			in_traceback = true
-- 		elseif in_traceback and line:match("^%s*%S") then
-- 			-- Append next non‑blank line (e.g. the error message) to the last entry
-- 			if #qflist > 0 then
-- 				qflist[#qflist].text = qflist[#qflist].text .. "\n" .. line
-- 			end
-- 		end
-- 	end
--
-- 	-- If no file/line was found, just dump the raw output as one fake entry
-- 	if #qflist == 0 then
-- 		table.insert(qflist, {
-- 			filename = file,
-- 			lnum = 1,
-- 			text = table.concat(output, "\n"),
-- 		})
-- 	end
--
-- 	-- Replace quickfix list with our entries
-- 	vim.fn.setqflist({}, " ", { items = qflist })
-- 	vim.cmd("Trouble quickfix close")
-- 	vim.cmd("Trouble quickfix toggle")
-- 	vim.cmd("cfirst")
-- end
--
-- Add keybinding (e.g. F5)
-- vim.keymap.set("n", "<F4>", RunPythonQuickfix, { desc = "Run Python → quickfix" })

-- - TODO look at this replace to add len() arond values
-- - :s/\\v\\w+/\\=printf('len(%s)', submatch(0))/g
