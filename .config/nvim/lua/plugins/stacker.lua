return {
  "tripplyons/stacker.nvim",
  event = "BufEnter",
  config = function()
    local stacker = require('stacker')
    local opts = {max_buffers = 8}
    stacker.setup(opts)

    -- <leader>1 will navigate to the most recently used buffer, <leader>2 for 2nd most recently used buffer, etc.
    for i = 1, 8 do
      vim.keymap.set('n', '<leader>' .. i, function()
        stacker.navigate(i)
      end)
    end

    -- <leader>dh will delete the buffer history for the current directory
    vim.keymap.set('n', '<leader>dh', function()
      stacker.clear_history()
    end, {
        desc = "delete all buffer hist",
    })


    local inactive_color = '#808080' -- replace with a custom color
    local active_color = '#ffffff' -- replace with a custom color
    local number_color = '#1188ca' -- replace with a custom color
    vim.cmd('highlight! StackerInactive guibg=NONE guifg='..inactive_color)
    vim.cmd('highlight! StackerActive guibg=NONE guifg='..active_color)
    vim.cmd('highlight! StackerNumber guibg=NONE guifg='..number_color)
  end
}
