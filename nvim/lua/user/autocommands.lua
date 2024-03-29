vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.cmd("autocmd BufEnter *.go,*.rs,*.cpp,*.c setlocal shiftwidth=4 tabstop=4")
vim.cmd("autocmd BufEnter ?akefile* setlocal shiftwidth=2 tabstop=2") -- For any Makefile, set indent to 2

vim.cmd("autocmd InsertEnter * if bufname() != 'NvimTree_1' | set relativenumber | endif")
vim.cmd("autocmd InsertLeave * if bufname() != 'NvimTree_1' | set norelativenumber | endif")

vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
	callback = function()
		vim.cmd("quit")
	end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
-- 	pattern = { "*.ts", "*.js", "*.tsx", ".jsx", "*.json", "*.css" },
-- 	callback = function()
-- 		vim.cmd("Prettier")
-- 	end,
-- })

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		vim.cmd("hi link illuminatedWord LspReferenceText")
		vim.cmd("GitGutterSignsDisable")
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		local line_count = vim.api.nvim_buf_line_count(0)
		if line_count >= 5000 then
			vim.cmd("IlluminatePauseBuf")
		end
	end,
})
