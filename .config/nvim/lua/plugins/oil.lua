return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { "echasnovski/mini.icons" },
  opts = {
    default_file_explorer = true,
    columns = {},
    keymaps = {
      ["q"] = "actions.close",
      ["<C-h>"] = false,
      ["<S-->"] = "actions.parent",
    },
    delete_to_trash = true,
    view_options = { show_hidden = false },
  },
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
  },
}
