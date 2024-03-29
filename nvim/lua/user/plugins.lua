local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
	git = {
		clone_timeout = 300, -- Timeout, in seconds, for git clones
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
	use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "numToStr/Comment.nvim" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "kyazdani42/nvim-tree.lua" })
	use({ "moll/vim-bbye" })
	use({ "nvim-lualine/lualine.nvim" })
	use({ "akinsho/toggleterm.nvim" })
	use({ "ahmedkhalf/project.nvim" })
	use({ "lewis6991/impatient.nvim" })
	use({ "lukas-reineke/indent-blankline.nvim" })
	use({ "goolord/alpha-nvim" })
	use({ "ggandor/leap.nvim" })

	-- Cool stuff I've found
	use({
		"samodostal/image.nvim",
		config = function()
			require("image").setup()
		end,
	})
	use({ "rest-nvim/rest.nvim" })
	use({ "ellisonleao/glow.nvim" }) -- Markdown preview
	use({ "feline-nvim/feline.nvim" })
	use({ "eandrju/cellular-automaton.nvim" })

	use({ "folke/lazy.nvim" })

	-- UI
	use({
		"folke/noice.nvim",
		requires = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	})

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter" })
	use({ "p00f/nvim-ts-rainbow" }) -- Must be loaded before 'bufferline' and any Colorschemes
	use({ "akinsho/bufferline.nvim" })
	use({ "uga-rosa/ccc.nvim" })

	-- Colorschemes
	use({ "cpea2506/one_monokai.nvim" })
	-- use({ "EdenEast/nightfox.nvim" })
	use({ "sainnhe/sonokai" })
	use({ "navarasu/onedark.nvim" })
	-- use({ "catppuccin/nvim", as = "catppuccin" })

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })
	-- tabnine AI Assistant
	use({
		"tzachar/cmp-tabnine",
		after = "nvim-cmp",
		run = "./install.sh",
	})

	-- snippets
	use({ "L3MON4D3/LuaSnip" }) --snippet engine
	use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use
	use({
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})

	-- LSP
	-- use { "williamboman/nvim-lsp-installer"  } -- simple to use language server installer
	use({ "neovim/nvim-lspconfig" }) -- enable LSP
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate" })
	use({ "folke/trouble.nvim" })
	use({ "j-hui/fidget.nvim" })
	use({ "MunifTanjim/prettier.nvim" })

	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })

	-- Golang
	-- use({ "crispgm/nvim-go" })
	use({
		"fatih/vim-go",
		run = ":GoUpdateBinaries",
		requires = {
			"junegunn/fzf.vim",
		},
	})

	-- Rust
	use({ "simrat39/rust-tools.nvim" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim" })

	-- Git
	use({ "lewis6991/gitsigns.nvim" })
	use({ "airblade/vim-gitgutter" })
	use({ "f-person/git-blame.nvim" })

	-- DAP
	use({ "mfussenegger/nvim-dap" })
	use({ "rcarriga/nvim-dap-ui" })
	use({ "ravenxrz/DAPInstall.nvim" })

	-- Which Key
	use({ "folke/which-key.nvim" })

	use({ "wakatime/vim-wakatime" })

	-- Undotree
	use({ "mbbill/undotree" })
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
