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

        -- Detect Love2D engine installation path (for runtime)
        local love_path = nil
        for _, p in ipairs({ "/usr/share/love", "/usr/lib/love", "/usr/local/share/love" }) do
            if vim.fn.isdirectory(p) == 1 then
                love_path = p
                break
            end
        end

        -- Detect Love2D API definitions (for lua_ls completions)
        -- Clone from: https://github.com/EmmyLua/Emmy-love-api (EmmyLua definitions)
        local love_api_root = nil
        for _, p in ipairs({
            vim.fn.expand("~/.local/share/love-api"),
            vim.fn.expand("~/love-api"),
            "/usr/local/share/love-api",
            "/usr/share/love-api",
        }) do
            if vim.fn.isdirectory(p) == 1 then
                love_api_root = p
                break
            end
        end

        local lua_ls_settings = {
            Lua = {
                diagnostics = { globals = { "vim", "love" } },
                runtime = { version = "LuaJIT" },
                workspace = {
                    library = {
                        vim.fn.stdpath("data") .. "/lazy/*/lua",
                        "/usr/share/nvim/runtime/lua",
                    },
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
            },
        }

        -- Add Love2D API root to userThirdParty (guarded: nil when not found)
        if love_api_root then
            lua_ls_settings.Lua.workspace.userThirdParty = { love_api_root }
        end

        -- Add Love2D engine path (runtime)
        if love_path then
            table.insert(lua_ls_settings.Lua.workspace.library, love_path)
        end

        -- Add Love2D API definitions (for completions)
        if love_api_root then
            table.insert(lua_ls_settings.Lua.workspace.library, love_api_root)
            table.insert(lua_ls_settings.Lua.workspace.library, love_api_root .. "/api")
            table.insert(lua_ls_settings.Lua.workspace.library, love_api_root .. "/modules")
        else
            -- Notify user how to get Love2D API completions
            vim.schedule(function()
                vim.notify(
                    "Love2D API definitions not found. For full Love2D completions (love.filesystem, love.graphics, etc.):\n"
                    .. "  git clone https://github.com/EmmyLua/Emmy-love-api ~/.local/share/love-api\n"
                    .. "Then restart Neovim.",
                    vim.log.levels.INFO,
                    { title = "Love2D LSP" }
                )
            end)
        end

        vim.lsp.config("lua_ls", {
            filetypes = { "lua" },
            cmd = { mason_path .. "/lua-language-server" },
            capabilities = capabilities,
            settings = lua_ls_settings,
        })

        vim.lsp.config("pyright", {
            filetypes = { "python" },
            capabilities = capabilities,
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
                map("<leader>cA", vim.lsp.buf.code_action, "Code action")
                map("<leader>rn", vim.lsp.buf.rename, "Rename")
                map("<leader>D", vim.lsp.buf.type_definition, "Type definition")
            end,
        })
    end,
}
