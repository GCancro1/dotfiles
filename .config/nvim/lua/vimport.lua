-- local map = vim.keymap.set
local opt = vim.opt

opt.diffopt:append("vertical")
opt.spelllang = "en_us"
opt.foldnestmax = 2
opt.foldlevelstart = 99
opt.fileencoding = "utf-8"
opt.colorcolumn = "+1"
opt.showmatch = true
opt.wildignorecase = true
-- opt.ttimeoutlen = 50

-- opt.path:append("src/**")

opt.wildignore:append({
    "**/venv/*",
    "**/.venv/*",
    "*/env/*",
    "*/.env/*",
    "**/site-packages/*",
    "*_venv/*",
    "*.pyc",
})

opt.shortmess:append("c")
opt.shortmess:append("I")

opt.infercase = true
opt.autoread = true

opt.formatoptions:append("j")
opt.joinspaces = false

-- opt.clipboard = "unnamedplus"

vim.keymap.set("i", "<C-BS>", "<C-W>", { noremap = true })
-- vim.keymap.set("c", "<C-BS>", "<C-W>", { noremap = true })

vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR><Esc>", { noremap = true })

vim.keymap.set("v", ".", ":norm .<CR>", { noremap = true })

vim.keymap.set("n", "d", '"_d', { noremap = true })
vim.keymap.set("v", "d", '"_d', { noremap = true })
vim.keymap.set("v", "D", '"_D', { noremap = true })

vim.keymap.set("n", "c", '"_c', { noremap = true })
vim.keymap.set("v", "c", '"_c', { noremap = true })
vim.keymap.set("n", "C", '"_C', { noremap = true })
vim.keymap.set("v", "C", '"_C', { noremap = true })

vim.keymap.set("n", "<leader>D", "D", {
    noremap = true,
    desc = "Cut (save to register)",
})


vim.keymap.set("n", "<leader>d", "d", {
    noremap = true,
    desc = "Cut (save to register)",
})

vim.keymap.set("v", "<leader>d", "d", {
    noremap = true,
    desc = "Cut (save to register)",
})

vim.keymap.set("n", "<leader>c", "c", {
    noremap = true,
    desc = "Change (save to register)",
})

vim.keymap.set("v", "<leader>c", "c", {
    noremap = true,
    desc = "Change (save to register)",
})

vim.keymap.set("n", "<leader>=", "<C-w>=", {
    desc = "Equalize windows",
})

vim.keymap.set("n", "<leader>ml", "99<C-w>h", {
    desc = "Focus left",
})

vim.keymap.set("n", "<leader>mr", "99<C-w>l", {
    desc = "Focus right",
})

-- vim.keymap.set("t", "<C-]>", "<C-\><C-n>", {
    -- noremap = true,
    -- })

    vim.keymap.set("n", "<A-j>", ":m.+1<CR>==", {
        noremap = true,
    })

    vim.keymap.set("n", "<A-k>", ":m.-2<CR>==", {
        noremap = true,
    })

    vim.keymap.set("i", "<A-j>", "<Esc>:m.+1<CR>==gi", {
        noremap = true,
    })

    vim.keymap.set("i", "<A-k>", "<Esc>:m.-2<CR>==gi", {
        noremap = true,
    })

    vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Move selection down" })
    vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv", { noremap = true, desc = "Move selection up" })
    vim.keymap.set("n", "<S-Down>", ":m.+1<CR>==", { noremap = true, desc = "Move line down" })
    vim.keymap.set("n", "<S-Up>", ":m.-2<CR>==", { noremap = true, desc = "Move line up" })
    vim.keymap.set("i", "<S-Down>", "<Esc>:m.+1<CR>==gi", { noremap = true, desc = "Move line down" })
    vim.keymap.set("i", "<S-Up>", "<Esc>:m.-2<CR>==gi", { noremap = true, desc = "Move line up" })

    vim.keymap.set("n", "<leader>Y", '"+Y', {
        desc = "Yank line to clipboard",
    })

    vim.keymap.set("v", "p", '"_dP', {
        noremap = true,
    })

    vim.keymap.set("n", "<leader>z", "<cmd>q!<CR>", {
        desc = "Force quit",
    })

    -- vim.keymap.set("n", "<leader>ca", "<cmd>bd!<CR>", {
        -- desc = "Force close buffer",
        -- })
        --
        vim.keymap.set("n", "<leader>cr", ":%d+<CR>", {
            desc = "Delete all (to register)",
        })

        vim.keymap.set("n", "<leader>ls", "<cmd>w<CR><cmd>source %<CR>", {
            desc = "Save & source file",
        })

        vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", {
            desc = "Next buffer",
        })

        vim.keymap.set("n", "<S-Tab>", "<cmd>bprev<CR>", {
            desc = "Prev buffer",
        })

        vim.keymap.set("n", "<leader>n", "<cmd>enew<CR>", {
            desc = "New buffer",
        })

        vim.keymap.set("n", "<leader>vn", "<cmd>new<CR>", {
            desc = "New vertical split",
        })

        vim.keymap.set("n", "<leader>vs", "<cmd>vsplit<CR>", {
            desc = "Vertical split",
        })

        vim.keymap.set("n", "<leader>fp", function()
            vim.fn.setreg("+", vim.fn.expand("%:p"))
        end, {
        desc = "Copy file dir",
    })

    vim.keymap.set("n", "<leader>fd", function()
        vim.fn.setreg("+", vim.fn.expand("%:p:h"))
    end, {
    desc = "Copy file dir",
})

vim.keymap.set("n", "<leader>sw", "<cmd>set wrap!<CR>", {
    desc = "Toggle wrap",
})

vim.keymap.set("n", "<leader>co", "<cmd>copen<CR>", {
    desc = "Quickfix open",
})

vim.keymap.set("n", "<leader>cc", "<cmd>cclose<CR>", {
    desc = "Quickfix close",
})

vim.keymap.set("n", "<leader>cn", "<cmd>cnext<CR>zz", {
    desc = "Quickfix next",
})

vim.keymap.set("n", "<leader>cp", "<cmd>cprev<CR>zz", {
    desc = "Quickfix prev",
})

vim.keymap.set("n", "<leader>cf", "<cmd>cfirst<CR>zz", {
    desc = "Quickfix first",
})

vim.keymap.set("n", "<leader>cl", "<cmd>clast<CR>zz", {
    desc = "Quickfix last",
})

vim.keymap.set("n", "<leader>cw", "<cmd>cwindow<CR>", {
    desc = "Quickfix window",
})

vim.keymap.set("n", "<leader>cO", "<cmd>colder<CR>", {
    desc = "Quickfix older list",
})

vim.keymap.set("n", "<leader>cN", "<cmd>cnewer<CR>", {
    desc = "Quickfix newer list",
})

vim.keymap.set("n", "<leader>cd", "<cmd>%+d<CR>", {
    desc = "Del all of file",
})

vim.keymap.set("n", "<leader>ca", "<cmd>%+y<CR>", {
    desc = "Copy all of file",
})

-- unsure if these are right below here
vim.keymap.set("c", "<C-BS>", "<C-W>")
vim.keymap.set("i", "<C-BS>", "<C-W>")





-- vim.keymap.set("v", "Y", "myy`y", ???)
-- vim.keymap.set("v", ???, "my`y", ???)

vim.keymap.set("n", "<A-Left>", "<C-W><C-H>")
vim.keymap.set("n", "<A-Right>", "<C-W><C-L>")
--
-- vim.keymap.set("n", "il", ":<C-u>normal! ^g_<CR>", ???)
-- vim.keymap.set("v", "il", ???)
--
-- vim.keymap.set("n", "<leader>fp", function()
    -- --     vim.fn.setreg("+", vim.fn.expand("%:p"))
    -- -- end)
    -- --
    -- vim.keymap.set("n", "<leader>ra",
    --     ":bufdo %s//ge | update" .. string.rep("<Left>", 12),
    --     ...)
