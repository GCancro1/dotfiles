-- Consolidated from init.lua + oldbinds.lua + vimport.lua (legacy files no longer loaded)

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- Editor
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.textwidth = 0
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.wrap = true
vim.opt.wrapmargin = 0 -- init.lua wins over oldbinds' 160
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.confirm = true
vim.opt.breakindent = true
vim.opt.showmatch = true
vim.opt.infercase = true
vim.opt.joinspaces = false
vim.opt.autoread = true
vim.opt.timeoutlen = 300
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.laststatus = 3
vim.opt.updatetime = 100

-- Visual aid
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.colorcolumn = "+1"

-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- Files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.fileencoding = "utf-8"

-- Formatting
vim.opt.formatoptions:remove("t")
vim.opt.formatoptions:append("j")

vim.opt.wildignorecase = true
vim.opt.wildignore:append({
    "**/venv/*",
    "**/.venv/*",
    "*/env/*",
    "*/.env/*",
    "**/site-packages/*",
    "*_venv/*",
    "*.pyc",
})

-- vim.opt.shortmess:append("c")
vim.opt.shortmess:append("I")

-- Diff / spell / folding
vim.opt.diffopt:append("vertical")
vim.opt.spelllang = "en_us"
vim.opt.foldnestmax = 2
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Vendored LÖVE API help (doc/ from davisdude/vim-love-docs build branch)
-- Searchable via <leader>sH (Snacks picker help) and :help love-<topic>
vim.opt.rtp:append(vim.fn.stdpath("config") .. "/love2d")
