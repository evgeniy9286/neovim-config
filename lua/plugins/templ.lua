return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			templ = {
				filetypes = { "templ" },
				settings = {
					templ = {
						enable_snippets = true,
					},
				},
			},
		},
	},
}
