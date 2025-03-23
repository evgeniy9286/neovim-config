return {
	"neovim/nvim-lspconfig",
	config = function()
		require("lspconfig").eslint.setup({
			settings = {
				enable = false,
			},
		})
	end,
}
