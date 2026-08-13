-- Binds the global `love` to the EmmyLua `love` class from the Love2D API definitions
-- (Emmy-love-api). Without this, lua_ls loads the class but never assigns it to the
-- global, so `love.` has no completions. This file is added to workspace.library.
---@type love
love = nil