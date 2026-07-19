return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = "default" },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 50,
                window = { border = "rounded" },
            },
            ghost_text = { enabled = true },
            menu = {
                border = "rounded",
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind_icon", "kind", gap = 1 },
                    },
                },
            },
        },
        signature = { enabled = true, window = { border = "rounded" } },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
    config = function(_, opts)
        local blink = require("blink.cmp")
        blink.setup(opts)

        local mason_path = vim.fn.stdpath("data") .. "/mason/bin"
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())

        vim.lsp.config("lua_ls", {
            cmd = { mason_path .. "/lua-language-server" },
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim" } },
                    workspace = {
                        library = {
                            vim.fn.stdpath("data") .. "/lazy/*/lua",
                            "/usr/share/nvim/runtime/lua",
                        },
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                },
            },
        })

        vim.lsp.enable("lua_ls")

        vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { fg = "#7aa2f7", bg = "NONE", bold = true })
        vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { bg = "#1e2030", fg = "#c0caf5" })
        vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#7aa2f7", bg = "NONE", bold = true })
        vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = "#1e2030", fg = "#c0caf5" })
        vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { fg = "#ff9e64", bold = true })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = args.buf, desc = desc })
                end
                map("gd", vim.lsp.buf.definition, "Go to definition")
                map("gr", vim.lsp.buf.references, "Go to references")
                map("gi", vim.lsp.buf.implementation, "Go to implementation")
                map("K", vim.lsp.buf.hover, "Hover")
                map("<leader>ca", vim.lsp.buf.code_action, "Code action")
                map("<leader>rn", vim.lsp.buf.rename, "Rename")
                map("<leader>D", vim.lsp.buf.type_definition, "Type definition")
            end,
        })
    end,
}
