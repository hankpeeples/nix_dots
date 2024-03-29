require("barbecue").setup({
	create_autocmd = false, -- prevent barbecue from updating itself automatically

	---whether to replace file icon with the modified symbol when buffer is modified
	---@type boolean
	show_modified = true,

	symbols = {
		---modification indicator
		---@type string
		modified = "●",

		---truncation indicator
		---@type string
		ellipsis = "…",

		---entry separator
		---@type string
		separator = "»",
	},
})

-- Gain better performance when moving cursor around
vim.api.nvim_create_autocmd({
	"WinScrolled",
	"BufWinEnter",
	"CursorHold",
	"InsertLeave",

	-- include these if you have set `show_modified` to `true`
	"BufWritePost",
	"TextChanged",
	"TextChangedI",
}, {
	group = vim.api.nvim_create_augroup("barbecue#create_autocmd", {}),
	callback = function()
		require("barbecue.ui").update()
	end,
})
