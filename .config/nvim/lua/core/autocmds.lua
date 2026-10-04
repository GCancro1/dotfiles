-- Autocmds
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})


vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.buftype ~= "" then
      vim.bo.buflisted = false
    end
  end,
})


-- Return to last cursor position when opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Restore cursor position",
})

-- Resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  callback = function() vim.cmd("wincmd =") end,
  desc = "Equalize splits on resize",
})

-- Close helper windows with 'q'
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man", "qf", "lspinfo", "checkhealth", "lazy", "mason" },
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
  desc = "Close with q",
})

-- Auto-create missing directories when writing
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(event)
    local dir = vim.fn.fnamemodify(event.file, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, "p") end
  end,
  desc = "Create dir on save",
})
