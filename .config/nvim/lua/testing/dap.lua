return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"igorlfs/nvim-dap-view",
		},

		config = function()
			local dap = require("dap")
			local dap_view = require("dap-view")

			local debugger_path = vim.fn.expand("~/.local/share/local-lua-debugger-vscode")
			dap_view.setup()

			dap.adapters["local-lua"] = {
				type = "executable",
				command = "node",
				args = {
					debugger_path .. "/extension/debugAdapter.js",
				},
				enrich_config = function(config, on_config)
					local enriched = vim.deepcopy(config)
					enriched.extensionPath = debugger_path .. "/"
					on_config(enriched)
				end,
			}

			dap.configurations.lua = {
				{
					name = "Launch current Lua file",
					type = "local-lua",
					request = "launch",
					cwd = "${workspaceFolder}",
					program = {
						lua = "lua5.4",
						file = "${file}",
					},
					args = {},
					repl_lang = "lua",
				},
			}

			dap.listeners.after.event_initialized["dap-view"] = function()
				dap_view.open()
			end

			local function close_debug_ui()
				dap_view.close()
			end

			dap.listeners.before.event_terminated["dap-view"] = close_debug_ui
			dap.listeners.before.event_exited["dap-view"] = close_debug_ui
		end,
	},
}
