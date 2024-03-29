local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = true,
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
					vim.lsp.buf.format({ async = false })
					-- vim.notify("Formatted")
				end,
			})
		end
	end,
	sources = {
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		-- diagnostics.semgrep.with({ extra_args = { "--config", "auto" } }), -- ts, tsx, go, and py static analysis
		diagnostics.revive.with({ -- Golang linter
			args = {
				"-config",
				"/home/hankp/.config/revive/config.toml",
				"-formatter",
				"json",
			},
		}),
		formatting.prettierd,
		formatting.rustfmt, -- Rust formatter
		formatting.rustywind, -- Tailwind css formatter
		diagnostics.checkmake,
		diagnostics.write_good,
		-- diagnostics.stylelint,
		-- diagnostics.eslint_d,
		diagnostics.jsonlint, -- JSON
		formatting.uncrustify, -- Java, C++, C, C#
	},
})
