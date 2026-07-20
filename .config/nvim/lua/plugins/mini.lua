return {
  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      -- Surround (g prefix to avoid flash conflicts: s, S, r, R)
      require("mini.surround").setup({
        mappings = {
          add = "gs",            -- Add surrounding in normal and visual
          delete = "gx",         -- Delete surrounding
          replace = "gZ",        -- Replace surrounding
          find = "g/",           -- Find surrounding to the right
          find_left = "g?",      -- Find surrounding to the left
          highlight = "gH",      -- Highlight surrounding
          suffix_last = "",      -- Suffix to search with "prev" method
          suffix_next = "",      -- Suffix to search with "next" method
        },
      })

      -- Extended textobjects (af/if, ac/ic, a'/i', etc.)
      require("mini.ai").setup()

      -- Highlight hex colors, TODOs, etc.
      require("mini.hipatterns").setup({
        highlighters = {
          hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
          TODO = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          FIXME = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          HACK = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          NOTE = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
        },
      })
    end,
  },
}
