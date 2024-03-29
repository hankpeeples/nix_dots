-- local status_ok, indent_blankline = pcall(require, "ibl")
-- if not status_ok then
-- 	return
-- end
--
-- indent_blankline.setup({
-- 	buftype_exclude = { "terminal", "nofile" },
-- 	filetype_exclude = {
-- 		"help",
-- 		"startify",
-- 		"dashboard",
-- 		"packer",
-- 		"neogitstatus",
-- 		"NvimTree",
-- 		"Trouble",
-- 		"text",
-- 	},
-- 	char = "𝄄",
-- 	space_char_blankline = "",
-- 	show_trailing_blankline_indent = false,
-- 	show_first_indent_level = false,
-- 	use_treesitter = true,
-- 	show_current_context = false,
-- })
local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}

local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup({
	exclude = {
		buftypes = {
			"terminal",
			"nofile",
		},
		filetypes = {
			"help",
			"startify",
			"dashboard",
			"packer",
			"neogitstatus",
			"NvimTree",
			"Trouble",
			"text",
		},
	},
	indent = {
		-- highlight = highlight,
		-- char = "𝄄",
	},
	scope = {
		enabled = true,
	},
})
