return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
	},
	opts = {
		ensure_installed = {
			"lua_ls",
			"pyright",
			"jsonls",
		},
		automatic_enable = true,
	},
}
