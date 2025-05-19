return {
	{
		"neovim/nvim-lspconfig",
		configg = function()
    require("indentmini").setup() -- use default config
end,
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				settings = { Lua = { diagnostics = { globals = { "vim", "require" } } } },
			})
			lspconfig.gopls.setup({
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
			})
			lspconfig.sqlls.setup({})
			lspconfig.cmake.setup({})
			lspconfig.cssls.setup({
				cmd = { "vscode-css-language-server", "--stdio" },
				filetypes = { "css", "scss", "less", "templ" },
				init_options = {provideFormatter = true},
				root_markers = { "package.json", ".git" },
				settings = {
							 css = {
									 validate = true
								   },
							 less = {
									 validate = true
									},
						     scss = {
									 validate = true
								    }
							}
			})
			lspconfig.cssmodules_ls.setup({
				cmd = { "cssmodules-language-server", "--stdio" },
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "templ" },
				root_markers = { "package.json" }
			})
			lspconfig.css_variables.setup({})
			lspconfig.vls.setup({})
			lspconfig.ts_ls.setup({
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"},
				root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" }
			})
			vim.cmd([[colorscheme tokyonight]])
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename Symbol" })
					vim.keymap.set({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<Leader>lf", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})
		end,
	},
}
