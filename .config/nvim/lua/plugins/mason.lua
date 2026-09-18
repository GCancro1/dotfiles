return {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
        ensure_installed = {
            "ruff",
            "stylua",
            "luacheck",
            "lua_ls", 
            "json_ls"
        },
        automatic_enable = true,
    },
}
