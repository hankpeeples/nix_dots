-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }
local nor_opts = { silent = true, noremap = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

keymap("n", ";", ":", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "wh", "<C-w>h", opts)
keymap("n", "wj", "<C-w>j", opts)
keymap("n", "wk", "<C-w>k", opts)
keymap("n", "wl", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Fun little animated thing
keymap("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press ii fast to enter
keymap("i", "kj", "<ESC>", opts)
keymap("v", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --
-- Prettier format
keymap("n", "<leader>x", ":Prettier<CR>", opts)

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Golang
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "go" },
	callback = function()
		keymap("n", "<leader>gR", "<Plug>(go-run-split)", opts)
		keymap("n", "<leader>gr", "<Plug>(go-rename)", opts)
		keymap("n", "<leader>gi", "<Plug>(go-info)", opts)
		keymap("n", "<leader>gT", "<Plug>(go-test)", opts)
		keymap("n", "<leader>gl", "<Plug>(go-lint)", opts)
		keymap("n", "<leader>gv", "<Plug>(go-vet)", opts)
		keymap("n", "<leader>gD", "<Plug>(go-doc-browser)", opts)
		keymap("n", "<leader>gd", "<Plug>(go-def)", opts)
		keymap("n", "<leader>gt", "<Plug>(go-def-type)", opts)
	end,
})

-- Rest API runner maps
keymap("n", "<leader>ps", "<Plug>RestNvim", opts)
keymap("n", "<leader>pS", "<Plug>RestNvimPreview", opts)
keymap("n", "<leader>pl", "<Plug>RestNvimLast", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- Restart treesitter rainbow
keymap("n", "<leader>ro", ":TSDisable rainbow<CR>", opts)
keymap("n", "<leader>rO", ":TSEnable rainbow<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
keymap("n", "]h", "<Plug>(GitGutterNextHunk)", opts)
keymap("n", "[h", "<Plug>(GitGutterPrevHunk)", opts)
keymap("n", "gh", "<Plug>(GitGutterUndoHunk)", nor_opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

vim.cmd([[
  " Move line down Ctrl-j up with Ctrl-k
  nnoremap <C-j> mz:m+<cr>`z
  nnoremap <C-k> mz:m-2<cr>`z
  vnoremap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
  vnoremap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z
]])

keymap("n", "<S-k>", "<cmd>lua require'rust-tools'.hover_actions.hover_actions()<cr>", opts)
keymap("n", "<leader>ra", "<cmd>lua require'rust-tools'.code_action_group.code_action_group()<cr>", opts)
keymap("n", "<leader>rr", "<cmd>lua require'rust-tools'.runnables.runnables()<cr>", opts)
keymap("n", "<leader>rc", "<cmd>lua require'rust-tools'.open_cargo_toml.open_cargo_toml()<cr>", opts)
keymap("n", "<leader>rp", "<cmd>lua require'rust-tools'.parent_module.parent_module()<cr>", opts)
keymap("n", "<leader>ro", "<cmd>lua require'rust-tools'.inlay_hints.enable()<cr>", opts)
keymap("n", "<leader>rO", "<cmd>lua require'rust-tools'.inlay_hints.disable()<cr>", opts)
