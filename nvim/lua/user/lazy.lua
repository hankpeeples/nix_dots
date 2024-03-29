local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{ "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
	{ "windwp/nvim-autopairs", lazy = true }, -- Autopairs, integrates with both cmp and treesitter
	{ "numToStr/Comment.nvim", lazy = true },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "nvim-tree/nvim-web-devicons" },
	-- { "moll/vim-bbye", lazy = true },
	{ "nvim-lualine/lualine.nvim", lazy = true },
	{ "akinsho/toggleterm.nvim", lazy = true },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{ "goolord/alpha-nvim", lazy = true },
	{ "ggandor/leap.nvim", lazy = true },

	{ "folke/lazy.nvim" },

	-- UI
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
	},
	{
		"akinsho/bufferline.nvim",
		version = "^3.*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{
		"luukvbaal/statuscol.nvim",
		config = function()
			require("statuscol").setup()
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
	},

	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter" },
	{ "HiPhish/rainbow-delimiters.nvim" },

	{ "styled-components/vim-styled-components" },
	{ "uga-rosa/ccc.nvim", lazy = true },

	-- Colorschemes
	{ "Shatur/neovim-ayu" },

	-- cmp plugins
	{ "hrsh7th/nvim-cmp", lazy = true }, -- The completion plugin
	{ "hrsh7th/cmp-buffer", lazy = true }, -- buffer completions
	{ "hrsh7th/cmp-path", lazy = true }, -- path completions
	{ "saadparwaiz1/cmp_luasnip" }, -- snippet completions
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },

	-- snippets
	{ "L3MON4D3/LuaSnip" }, --snippet engine
	{ "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	-- LSP
	{ "williamboman/nvim-lsp-installer" }, -- simple to use language server installer
	{ "neovim/nvim-lspconfig" }, -- enable LSP
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters
	{ "RRethy/vim-illuminate" },
	{ "folke/trouble.nvim" },
	{ "j-hui/fidget.nvim" },
	{ "MunifTanjim/prettier.nvim" },

	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },

	{
		"fatih/vim-go",
		run = ":GoUpdateBinaries",
		dependencies = {
			"junegunn/fzf.vim",
		},
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = "nvim-telescope/telescope-media-files.nvim",
	},

	-- Git
	{ "lewis6991/gitsigns.nvim" },
	{ "airblade/vim-gitgutter" },
	{ "f-person/git-blame.nvim" },
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
	},

	-- Which Key
	{ "folke/which-key.nvim" },

	{ "wakatime/vim-wakatime" },

	-- Undotree
	{ "mbbill/undotree" },
}

require("lazy").setup(plugins)
