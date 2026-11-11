return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"igorlfs/nvim-dap-view",
				opts = {
					winbar = {
						default_section = "scopes"
					},
					windows = {
						-- `prev` is the last used position, might be nil
						position = function(prev)
							local wins = vim.api.nvim_tabpage_list_wins(0)

							-- Restores previous position if terminal is visible
							if
								vim.iter(wins):find(function(win)
									return vim.w[win].dapview_win_term
								end)
							then
								return prev
							end

							return vim.tbl_count(vim.iter(wins)
								:filter(function(win)
									local buf = vim.api.nvim_win_get_buf(win)
									local valid_buftype = vim.tbl_contains(
										{ "", "help", "prompt", "quickfix", "terminal" },
										vim.bo[buf].buftype
									)
									local dapview_win = vim.w[win].dapview_win or vim.w[win].dapview_win_term
									return valid_buftype and not dapview_win
								end)
								:totable()) > 1 and "below" or "right"
						end,
						size = function(pos)
							return pos == "below" and 0.25 or 0.5
						end,
						terminal = {
							-- `pos` is the position for the regular window
							position = function(pos)
								return pos == "below" and "right" or "below"
							end,
							size = 0.5,
						},
					},
				},
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {
					enabled = true,
					enabled_commands = true,
					highlight_changed_variables = true,
					highlight_new_as_changed = true,
					show_stop_reason = true,
					commented = false,
					only_first_definition = true,
					all_references = false,
					virt_text_pos = "eol",
				},
			},
		},

		keys = {
			{
				"<F2>",
				function()
					require("dap").continue()
				end,
				desc = "Debug: Continue",
			},
			{
				"<F4>",
				function()
					require("dap").step_over()
				end,
				desc = "Debug: Step over",
			},
			{
				"<F3>",
				function()
					require("dap").step_into()
				end,
				desc = "Debug: Step into",
			},
			{
				"<F5>",
				function()
					require("dap").step_out()
				end,
				desc = "Debug: Step out",
			},

			{
				"<F1>",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Debug: Toggle breakpoint",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Debug: Toggle breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Debug: Conditional breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Debug: Continue",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "Debug: Open REPL",
			},
			{
				"<F7>",
				function()
					require("dap-view").toggle()
				end,
				desc = "Debug: Toggle UI",
			},
			{
				"<leader>du",
				function()
					require("dap-view").toggle()
				end,
				desc = "Debug: Toggle UI",
			},
			{
				"<leader>dx",
				function()
					require("dap").terminate()
				end,
				desc = "Debug: Terminate",
			},
			{
				"<leader>de",
				function()
					require("dap").set_exception_breakpoints()
				end,
				desc = "Debug: Exception breakpoints",
			},
			{
				"<F8>",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "Debug: Inspect variable",
			},
			{
				"<F9>",
				function()
					require("dap.ui.widgets").preview()
				end,
				desc = "Debug: Preview variable",
			},
			{
				"<leader>dh",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "Debug: Inspect variable",
			},
			{
				"<leader>dp",
				function()
					require("dap.ui.widgets").preview()
				end,
				desc = "Debug: Preview variable",
			},
		},

		config = function()
			local dap = require("dap")
			local dap_view = require("dap-view")

			local debugger_path = vim.fn.expand("~/.local/share/local-lua-debugger-vscode")

			dap_view.setup()

			local lines = vim.fn.systemlist({ "luarocks", "--lua-version=5.4", "path" })
			vim.print(lines)

			for _, line in ipairs(lines) do
				local key, value = line:match("^export%s+([%w_]+)='(.*)'$")
				if key == "LUA_PATH" or key == "LUA_CPATH" then
					vim.env[key] = value
				end
			end

			vim.print(vim.env.LUA_PATH, vim.env.LUA_CPATH)

			require("nvim-dap-virtual-text").setup({
				enabled = true,
				highlight_changed_variables = true,
				show_stop_reason = true,
				virt_text_pos = "eol",
			})

			dap.adapters["local-lua"] = {
				type = "executable",
				command = "node",
				args = {
					debugger_path .. "/extension/debugAdapter.js",
				},

				enrich_config = function(config, on_config)
					if config.extensionPath then
						on_config(config)
					else
						local enriched = vim.deepcopy(config)
						enriched.extensionPath = debugger_path .. "/"
						on_config(enriched)
					end
				end,
			}

			dap.configurations.lua = {
				{
					name = "DAP current Lua file",
					type = "local-lua",
					request = "launch",
					cwd = "${workspaceFolder}",
					program = {
						lua = "/usr/bin/lua5.4",
						file = "${file}",
					},
					args = { "-v" },
					env = {
						LUA_PATH_5_4 = "/usr/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?/init.lua;/usr/share/lua/5.4/?/init.lua;/usr/local/lib/lua/5.4/?.lua;/usr/local/lib/lua/5.4/?/init.lua;/usr/lib/lua/5.4/?.lua;/usr/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/home/g/.luarocks/share/lua/5.4/?.lua;/home/g/.luarocks/share/lua/5.4/?/init.lua",
						LUA_CPATH_5_4 = "/usr/local/lib/lua/5.4/?.so;/usr/lib/lua/5.4/?.so;/usr/local/lib/lua/5.4/loadall.so;/usr/lib/lua/5.4/loadall.so;./?.so;/home/g/.luarocks/lib/lua/5.4/?.so",
					},
				},
			}

			dap.listeners.after.event_initialized["dap-view"] = function()
				dap_view.open()
			end

			local function close_debug_ui()
				dap_view.close()
			end

			-- dap.listeners.before.event_terminated["dap-view"] = close_debug_ui
			-- dap.listeners.before.event_exited["dap-view"] = close_debug_ui

			dap.listeners.after.event_terminated.lua_terminated_notice = function()
				vim.schedule(function()
					vim.notify("DAP session terminated")
				end)
			end
			dap.listeners.after.event_exited["lua-exit-notice"] = function(_, body)
				local code = body.exitCode
				vim.schedule(function()
					vim.notify(
						"Debugged process exited" .. (code ~= nil and (" with code " .. code) or ""),
						vim.log.levels.INFO
					)
				end)
			end
			-- Breakpoint and debugging signs
			vim.fn.sign_define("DapBreakpoint", {
				text = "🔴",
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapBreakpointCondition", {
				text = "🔶",
				texthl = "DapBreakpointCondition",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapBreakpointRejected", {
				text = "✘",
				texthl = "DapBreakpointRejected",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapLogPoint", {
				text = "◆",
				texthl = "DapLogPoint",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapStopped", {
				text = "▶",
				texthl = "DapStopped",
				linehl = "DapStoppedLine",
				numhl = "",
			})
			vim.api.nvim_set_hl(0, "DapBreakpoint", {
				fg = "#ff5555",
				bold = true,
			})

			vim.api.nvim_set_hl(0, "DapBreakpointCondition", {
				fg = "#ffb86c",
				bold = true,
			})

			vim.api.nvim_set_hl(0, "DapBreakpointRejected", {
				fg = "#ff0000",
				bold = true,
			})

			vim.api.nvim_set_hl(0, "DapLogPoint", {
				fg = "#50fa7b",
				bold = true,
			})

			vim.api.nvim_set_hl(0, "DapStopped", {
				fg = "#50fa7b",
				bold = true,
			})

			vim.api.nvim_set_hl(0, "DapStoppedLine", {
				bg = "#3b424f",
			})
		end,
	},
}
