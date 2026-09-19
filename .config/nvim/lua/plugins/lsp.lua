return {

	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		vim.o.winborder = "rounded"

		vim.diagnostic.config({
			severity_sort = true,
			float = { source = true },
			virtual_text = { spacing = 2, source = "if_many" },
		})

		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})

		vim.lsp.config("lua_ls", {
			root_dir = function(bufnr, on_dir)
				local fname = vim.api.nvim_buf_get_name(bufnr)
				local root = vim.fs.root(fname, { ".luarc.json", ".luarc.jsonc", ".git" }) or vim.fs.dirname(fname)
				on_dir(root)
			end,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim", "Snacks" } },
                    format = {enable = false},
					telemetry = { enable = false },
					workspace = {
						checkThirdParty = false,
						library = {
							"~/.local/share/nvim/lazy/love2d/library/",
							"/usr/share/lua/5.5",
						},
					},
				},
			},
		})

		vim.lsp.config("jsonls", {
			settings = {
				json = { validate = { enable = true } },
			},
		})

		local lsp_group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = lsp_group,
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
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
				map("<leader>ih", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, "Toggle inlay hints")

				if client and client:supports_method("textDocument/inlayHint") then
					vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
				end

				map("grd", Snacks.picker.lsp_definitions, "Go to definition")
				map("grr", Snacks.picker.lsp_references, "Go to references")
				map("gri", Snacks.picker.lsp_implementations, "Go to implementation")
				map("go", Snacks.picker.lsp_symbols, "Type definition")
				map("gW", Snacks.picker.lsp_workspace_symbols, "Type workspace definition")
				map("grt", Snacks.picker.lsp_type_definitions, "Type definition")

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client and client:supports_method("textDocument/documentHighlight", args.buf) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = args.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = args.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end
			end,
		})

		-- Add back :LspInfo, :LspRestart, :LspLog commands
		vim.api.nvim_create_user_command("LspInfo", function()
			vim.cmd("checkhealth lsp")
		end, { desc = "Show LSP health/info" })

		vim.api.nvim_create_user_command("LspRestart", function(opts)
			local name = opts.args ~= "" and opts.args or "lua_ls"
			local clients = vim.lsp.get_clients({ name = name })
			if #clients > 0 then
				for _, client in ipairs(clients) do
					vim.lsp.stop_client(client.id, true)
				end
				vim.defer_fn(function()
					vim.lsp.enable(name)
				end, 100)
				print("Restarted LSP: " .. name)
			else
				print("No LSP client found: " .. name)
			end
		end, { nargs = "?", desc = "Restart LSP client (default: lua_ls)" })

		vim.api.nvim_create_user_command("LspLog", function()
			print("LSP log: " .. vim.lsp.get_log_path())
			vim.cmd("tabnew " .. vim.lsp.get_log_path())
		end, { desc = "Open LSP log file" })

		-- Notify Love2D API status
		vim.schedule(function()
			if love_api_path then
				vim.notify("Love2D API loaded from: " .. love_api_path, vim.log.levels.INFO, { title = "Love2D LSP" })
			else
				vim.notify(
					"Love2D API definitions not found. For full Love2D completions:\n"
						.. "  git clone https://github.com/EmmyLua/Emmy-love-api ~/.local/share/love-api\n"
						.. "Then run :LspRestart lua_ls",
					vim.log.levels.WARN,
					{ title = "Love2D LSP" }
				)
			end
		end)
	end,
}

-- return {
--   -- Love2D LSP configuration using native Neovim 0.11+ API
--   -- Provides :LspInfo, :LspRestart, :LspLog commands
--   {
--     "neovim/nvim-lspconfig",
--     config = function()
--       vim.diagnostic.config({
--         float = { border = "rounded" },
--       })
--
--       -- Rounded borders for LSP hover and signature help
--       vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
--         vim.lsp.handlers.hover,
--         { border = "rounded" }
--       )
--       vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
--         vim.lsp.handlers.signature_help,
--         { border = "rounded" }
--       )
--
--       -- Detect Love2D API definitions (EmmyLua format)
--       local love_api_path = nil
--       local search_paths = {
--         vim.fn.expand("~/.local/share/love-api/api"),
--         vim.fn.expand("~/.local/share/love-api"),
--         vim.fn.expand("~/love-api/api"),
--         vim.fn.expand("~/love-api"),
--         "/usr/local/share/love-api/api",
--         "/usr/local/share/love-api",
--         "/usr/share/love-api/api",
--         "/usr/share/love-api",
--       }
--
--       for _, p in ipairs(search_paths) do
--         if vim.fn.isdirectory(p) == 1 then
--           love_api_path = p
--           vim.notify("Love2D API found at: " .. p, vim.log.levels.DEBUG, { title = "Love2D LSP" })
--           break
--         else
--           vim.notify("Love2D API NOT found at: " .. p, vim.log.levels.DEBUG, { title = "Love2D LSP" })
--         end
--       end
--
--       -- Build workspace.library without nil entries
--       local library = {
--         vim.fn.stdpath("data") .. "/lazy/*/lua",
--         "/usr/share/nvim/runtime/lua",
--       }
--       local love_globals_dir = vim.fn.stdpath("config") .. "/love2d"
--       if love_api_path then
--         table.insert(library, love_api_path)
--         if vim.fn.isdirectory(love_globals_dir) == 1 then
--           table.insert(library, love_globals_dir)
--         end
--       end
--
--       -- Configure lua_ls
--       vim.lsp.config("lua_ls", {
--         filetypes = { "lua" },
--         settings = {
--           Lua = {
--             runtime = { version = "LuaJIT" },
--             diagnostics = { globals = { "vim", "love" } },
--             workspace = {
--               library = library,
--               checkThirdParty = false,
--             },
--             telemetry = { enable = false },
--           },
--         },
--       })
--
--       -- Enable lua_ls
--       vim.lsp.enable("lua_ls")
--
--       -- Add back :LspInfo, :LspRestart, :LspLog commands
--       vim.api.nvim_create_user_command("LspInfo", function()
--         vim.cmd("checkhealth lsp")
--       end, { desc = "Show LSP health/info" })
--
--       vim.api.nvim_create_user_command("LspRestart", function(opts)
--         local name = opts.args ~= "" and opts.args or "lua_ls"
--         local clients = vim.lsp.get_clients({ name = name })
--         if #clients > 0 then
--           for _, client in ipairs(clients) do
--             vim.lsp.stop_client(client.id, true)
--           end
--           vim.defer_fn(function()
--             vim.lsp.enable(name)
--           end, 100)
--           print("Restarted LSP: " .. name)
--         else
--           print("No LSP client found: " .. name)
--         end
--       end, { nargs = "?", desc = "Restart LSP client (default: lua_ls)" })
--
--       vim.api.nvim_create_user_command("LspLog", function()
--         print("LSP log: " .. vim.lsp.get_log_path())
--         vim.cmd("tabnew " .. vim.lsp.get_log_path())
--       end, { desc = "Open LSP log file" })
--
--       -- Notify Love2D API status
--       vim.schedule(function()
--         if love_api_path then
--           vim.notify(
--             "Love2D API loaded from: " .. love_api_path,
--             vim.log.levels.INFO,
--             { title = "Love2D LSP" }
--           )
--         else
--           vim.notify(
--             "Love2D API definitions not found. For full Love2D completions:\n"
--             .. "  git clone https://github.com/EmmyLua/Emmy-love-api ~/.local/share/love-api\n"
--             .. "Then run :LspRestart lua_ls",
--             vim.log.levels.WARN,
--             { title = "Love2D LSP" }
--           )
--         end
--       end)
--     end,
--   },
-- }
