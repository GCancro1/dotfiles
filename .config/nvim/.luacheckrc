-- luacheck configuration
std = "lua51"

-- Global objects
globals = {
    "love",
    "vim",
}

-- Read-only globals
read_globals = {
    "describe",
    "it",
    "assert",
    "before_each",
    "after_each",
}

-- Ignore unused loop variables (common in LOVE2D: function love.update(dt))
ignore = {
    "212",   -- unused argument
    "213",   -- unused loop variable
}

-- Max line length (0 = no limit)
max_line_length = 0
