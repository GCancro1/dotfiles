return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"igorlfs/nvim-dap-view",
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
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "Debug: Continue",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "Debug: Step over",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "Debug: Step into",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "Debug: Step out",
			},

			{
				"<leader>bb",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Debug: Toggle breakpoint",
			},
			{
				"<leader>bB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Debug: Conditional breakpoint",
			},
			{
				"<leader>bc",
				function()
					require("dap").continue()
				end,
				desc = "Debug: Continue",
			},
			{
				"<leader>br",
				function()
					require("dap").repl.open()
				end,
				desc = "Debug: Open REPL",
			},
			{
				"<leader>bu",
				function()
					require("dap-view").toggle()
				end,
				desc = "Debug: Toggle UI",
			},
			{
				"<leader>bx",
				function()
					require("dap").terminate()
				end,
				desc = "Debug: Terminate",
			},
			{
				"<leader>be",
				function()
					require("dap").set_exception_breakpoints()
				end,
				desc = "Debug: Exception breakpoints",
			},
			{
				"<leader>bh",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "Debug: Inspect variable",
			},
			{
				"<leader>bp",
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

			-- Breakpoint and debugging signs
			vim.fn.sign_define("DapBreakpoint", {
				text = "●",
				texthl = "DapBreakpoint",
			})

			vim.fn.sign_define("DapStopped", {
				text = "▶",
				texthl = "DapStopped",
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
