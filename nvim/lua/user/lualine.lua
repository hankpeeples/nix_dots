local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

-- local hide_in_width = function()
-- 	return vim.fn.winwidth(0) > 80
-- end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = true,
	always_visible = true,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	-- cond = hide_in_width,
}

local git_blame = require("gitblame")
local function blame()
	if git_blame.is_blame_text_available() then
		local b = string.format("%s", git_blame.get_current_blame_text())
		if b == "  Not Committed Yet" then -- there are 2 spaces preceding the not committed string, don't remove
			return ""
		end
		return b
	else
		return ""
	end
end

local filetype = {
	"filetype",
	icons_enabled = true,
}

local location = {
	"location",
	padding = 0,
}

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local function lsp_client()
	local buf_clients = vim.lsp.get_clients()
	if next(buf_clients) == nil then
		return ""
	end
	local buf_client_names = {}
	for _, client in pairs(buf_clients) do
		if client.name ~= "null-ls" then
			table.insert(buf_client_names, client.name)
		end
	end
	return table.concat(buf_client_names, ", ")
end

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard" },
		always_divide_middle = false,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", diff },
		lualine_c = { diagnostics, "%=", blame },
		lualine_x = { { lsp_client, icon = "", color = { fg = "#8588ff" } }, spaces },
		lualine_y = { "encoding", location, "  " },
		lualine_z = { "progress" },
	},
})
