-- require("go").setup({
-- 	-- notify: use nvim-notify
-- 	notify = true,
-- 	-- auto commands
-- 	auto_format = true,
-- 	auto_lint = false,
-- 	-- linters: revive, errcheck, staticcheck, golangci-lint
-- 	linter = "revive",
-- 	linter_flags = { revive = { "-config", "~/.config/revive/config.toml" } },
-- 	-- lint_prompt_style: qf (quickfix), vt (virtual text)
-- 	lint_prompt_style = "vt",
-- 	-- formatter: goimports, gofmt, gofumpt, lsp
-- 	formatter = "goimports",
-- 	-- maintain cursor position after formatting loaded buffer
-- 	maintain_cursor_pos = false,
-- 	-- test flags: -count=1 will disable cache
-- 	test_flags = { "-v" },
-- 	test_timeout = "30s",
-- 	test_env = {},
-- 	-- show test result with popup window
-- 	test_popup = true,
-- 	test_popup_auto_leave = false,
-- 	test_popup_width = 140,
-- 	test_popup_height = 20,
-- 	-- test open
-- 	test_open_cmd = "edit",
-- 	-- struct tags
-- 	tags_name = "json",
-- 	tags_options = { "json=omitempty" },
-- 	tags_transform = "snakecase",
-- 	tags_flags = { "-skip-unexported" },
-- 	-- quick type
-- 	quick_type_flags = { "--just-types" },
-- })

vim.g.go_test_show_name = 1
vim.g.go_fmt_command = "goimports"
vim.g.go_imports_mode = "goimports"
vim.g.go_term_enabled = 1
vim.g.go_auto_type_info = 0
vim.g.go_doc_balloon = 1
vim.g.go_diagnostics_level = 2 -- 0 = none, 1 = errors, 2 = errors & warnings
vim.g.go_highlight_chan_whitespace_error = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_generate_tags = 1
