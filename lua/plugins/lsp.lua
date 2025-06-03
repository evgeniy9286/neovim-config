return {
	{
		"neovim/nvim-lspconfig",
		configg = function()
			require("indentmini").setup() -- use default config
		end,
		configgo = function()
			require("golangci-lint-langserver").setup({})
		end,
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})
			local lspconfig = require("lspconfig")
			local servers = { 'gopls', 'ccls', 'cmake', 'templ' }
			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end
			lspconfig.lua_ls.setup({
				settings = { Lua = { diagnostics = { globals = { "vim", "require" } } } },
			})
			lspconfig.gopls.setup({
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
			})
			lspconfig.sqlls.setup({})
			lspconfig.cmake.setup({})
			lspconfig.vls.setup({})
			lspconfig.ts_ls.setup({
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
				root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" }
			})
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "html", "templ" },
			})
			lspconfig.htmx.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "html", "templ" },
			})
			lspconfig.tailwindcss.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "templ", "astro", "javascript", "typescript", "react" },
				settings = {
					tailwindCSS = {
						includeLanguages = {
							templ = "html",
						},
					},
				},
			})
			lspconfig.dockerls.setup({
				cmd = { "docker-langserver", "--stdio" },
				filetypes = { "dockerfile" },
				root_markers = { "Dockerfile" }
			})
			lspconfig.docker_compose_language_service.setup({
				cmd = { "docker-compose-langserver", "--stdio" },
				filetypes = { "yaml.docker-compose" },
				root_markers = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" }
			})
			lspconfig.postgres_lsp.setup({
				cmd = { "postgrestools", "lsp-proxy" },
				filetypes = { "sql" },
				root_markers = { "postgrestools.jsonc" }
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
