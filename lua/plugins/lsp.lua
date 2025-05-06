return {
	{
		"neovim/nvim-lspconfig",
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
			lspconfig.dockerls.setup({})
			lspconfig.cmake.setup({})
			lspconfig.templ.setup({
				filetypes = { "templ", "html", "css", "gopls" },
			})
			lspconfig.vuels.setup({})
			lspconfig.eslint.setup({})
			lspconfig.html.setup({
				cmd = { "vscode-html-language-server.cmd", "--stdio" },
				filetypes = { "html", "templ" },
			})

lspconfig.htmx.setup({
    filetypes = { "html", "templ" },
})
			lspconfig.tailwindcss.setup({
filetypes = { "templ", "astro", "javascript", "typescript", "react" },
    settings = {
      tailwindCSS = {
        includeLanguages = {
          templ = "html",
        },
      },
    },
				})
			lspconfig.cssls.setup({
				cmd = { "vscode-css-language-server.cmd", "--stdio" },
				filetypes = { "html", "templ", "css", "scss", "less" },
			})
			lspconfig.ts_ls.setup({
				cmd = { "vscode-typescript-language-server.cmd", "--stdio" },
				filetypes = { "ts", "tsx" },
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
