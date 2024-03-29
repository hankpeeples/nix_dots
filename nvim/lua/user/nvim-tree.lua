require("nvim-tree").setup({
	on_attach = "default",
	disable_netrw = true,
	hijack_cursor = true,
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	renderer = {
		highlight_git = true,
		root_folder_modifier = ":t",
		indent_width = 2,
		indent_markers = {
			enable = true,
		},
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_open = "",
					arrow_closed = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "✎",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					untracked = "U",
					deleted = "",
					ignored = "◌",
				},
			},
		},
		special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "go.mod" },
	},
	filters = {
		dotfiles = false,
		custom = { ".DS_Store" },
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	view = {
		side = "left",
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
})
