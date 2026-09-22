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
