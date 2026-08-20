-- Core config
require("core.options")
require("core.keymaps")
require("core.autocmds")

vim.filetype.add({ extension = { vil = "json" }})

-- Open help in current window (no split)
-- Mirrors Snacks' stock help-picker confirm (Snacks.picker.actions.help):
-- 1. Resolve the plugin that owns the doc file from its path ("/<plugin>/doc/")
--    and lazy-load it BEFORE running :help. Without this, tags living in docs
--    of lazy-loaded plugins fail to resolve (E149) or land at the top of file.
-- 2. Window juggling without `wincmd p`: let :help split, then move the help
--    buffer back into the origin window. nvim_win_set_buf resets the cursor to
--    line 1, so the tag line is captured first and restored explicitly (that
--    was the "always lands at top" bug). All command errors are pcall'd so a
--    bad tag can never scramble window layout.
_G.help_no_split = function(topic)
    if not topic or topic == "" then
        vim.cmd("help")
        return
    end
    local w1 = vim.api.nvim_get_current_win()
    local ok = pcall(function()
        if package.loaded.lazy then
            -- Same lazy-load step as the stock confirm: find the tags file the
            -- topic lives in (searching rtp incl. unloaded plugins' dirs, as
            -- the help source does), derive the plugin from the doc path, and
            -- load it if it is a registered lazy plugin.
            local rtp = vim.o.runtimepath
                .. ","
                .. table.concat(require("lazy.core.util").get_unloaded_rtp(""), ",")
            local doc
            for _, file in ipairs(vim.fn.globpath(rtp, "doc/*", true, true)) do
                local name = vim.fn.fnamemodify(file, ":t")
                if name == "tags" or name:sub(1, 5) == "tags-" then
                    for line in io.lines(file) do
                        if not line:match("^!_TAG_") and vim.split(line, "\t", { plain = true })[1] == topic then
                            doc = file
                            break
                        end
                    end
                end
                if doc then break end
            end
            local plugin = doc and doc:match("/([^/]+)/doc/")
            if plugin and require("lazy.core.config").plugins[plugin] then
                require("lazy").load({ plugins = { plugin } })
            end
        end
        vim.cmd("help " .. topic)
    end)
    if not ok then
        vim.notify("No help found for " .. topic, vim.log.levels.WARN)
        return
    end
    local w2 = vim.api.nvim_get_current_win()
    if w2 == w1 then
        -- :help reused the current window (2nd+ run, current win already shows
        -- a help buffer); it already jumped to the tag itself.
        return
    end
    local help_buf = vim.api.nvim_win_get_buf(w2)
    local cursor = vim.api.nvim_win_get_cursor(w2) -- tag line in the new window
    vim.api.nvim_win_set_buf(w1, help_buf)
    vim.api.nvim_win_set_cursor(w1, cursor)
    vim.api.nvim_win_close(w2, true)
    vim.api.nvim_set_current_win(w1)
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. out)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "plugins" },
})
