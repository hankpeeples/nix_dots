local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
-- dashboard.section.header.val = {
-- 	[[                               __                ]],
-- 	[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
-- 	[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
-- 	[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
-- 	[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
-- 	[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
-- }

dashboard.section.header.val = {
	[[             ________________________________________________]],
	[[            /                                                \]],
	[[           |    _________________________________________     |]],
	[[           |   |                                         |    |]],
	[[           |   |  C:\> _                                 |    |]],
	[[           |   |                                         |    |]],
	[[           |   |                                         |    |]],
	[[           |   |                                         |    |]],
	[[           |   |                                         |    |]],
	[[           |   |                                         |    |]],
	[[           |   |_________________________________________|    |]],
	[[           |                                                  |]],
	[[            \_________________________________________________/]],
	[[                   \___________________________________/]],
	[[                ___________________________________________]],
	[[             _-'    .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.  --- `-_]],
	[[          _-'.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.--.  .-.-.`-_]],
	[[       _-'.-.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-`__`. .-.-.-.`-_]],
	[[    _-'.-.-.-.-. .-----.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-----. .-.-.-.-.`-_]],
	[[ _-'.-.-.-.-.-. .---.-. .-------------------------. .-.---. .---.-.-.-.`-_]],
	[[:-------------------------------------------------------------------------:]],
	[[`---._.-------------------------------------------------------------._.---']],
}

dashboard.section.buttons.val = {
	dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
	dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}

vim.api.nvim_create_autocmd("User", {
	-- pattern = "VimEnter",
	callback = function()
		local stats = require("lazy").stats()
		local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
		dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
	end,
})

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
