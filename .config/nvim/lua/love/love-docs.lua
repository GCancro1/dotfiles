return {
	-- Vendored LÖVE API help from davisdude/vim-love-docs (build branch).
	-- Declared as a dir plugin so lazy.nvim puts love2d/ on the runtimepath
	-- after its rtp reset (performance.rtp.reset), which would otherwise wipe
	-- the append from core/options.lua. doc/tags makes :help love-* and
	-- <leader>sH (Snacks picker help) searchable.
	{
		dir = vim.fn.stdpath("config") .. "/love2d",
		name = "love-docs",
		lazy = false,
	},
}
