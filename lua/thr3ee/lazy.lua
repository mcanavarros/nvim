-- Install package manager

--    https://github.com/folke/lazy.nvim

--    `:help lazy.nvim.txt` for more info

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'


if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end

vim.opt.rtp:prepend(lazypath)


require('lazy').setup({

	-- Git related plugins
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',

	-- Detect tabstop and shiftwidth automatically
	'tpope/vim-sleuth',

	{

		"folke/noice.nvim",

		event = "VeryLazy",

		opts = {
		},

		dependencies = {

			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		}
	},

	-- File explorer
	{
		'nvim-tree/nvim-tree.lua',
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
	},

	-- Auto pair
	{
		'windwp/nvim-autopairs',
		event = "insertEnter",
		opts = {},
	},

	-- Surround
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
			})
		end

	},

	-- LSP
	{

		'VonHeikemen/lsp-zero.nvim',

		branch = 'v2.x',

		dependencies = {

			-- LSP Support
			{ 'neovim/nvim-lspconfig' },
			{ 'folke/neodev.nvim' },
			{
				'williamboman/mason.nvim',
				build = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
			{ 'williamboman/mason-lspconfig.nvim' },

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'hrsh7th/cmp-cmdline' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua' },

			-- Snippets
			{
				'L3MON4D3/LuaSnip',
				version = "v2.*",
				run = "make install_jsregexp"
			},
			{ 'rafamadriz/friendly-snippets' },

		}
	},

	-- Navigtion
	'theprimeagen/harpoon',

	-- WeztermNavigation
	'mrjones2014/smart-splits.nvim',

	-- Undo tree
	'mbbill/undotree',

	-- Debugger
	'mfussenegger/nvim-dap',
	'rcarriga/nvim-dap-ui',

	-- Useful plugin to show you pending keybinds.
	{ 'folke/which-key.nvim',          opts = {} },

	-- Adds git releated signs to the gutter, as well as utilities for managing changes
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},

			on_attach = function(bufnr)
				vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
					{ buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
				vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
					{ buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
				vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
					{ buffer = bufnr, desc = '[P]review [H]unk' })
			end,
		},
	},

	{
		-- Theme inspired by Atom
		'navarasu/onedark.nvim',
		priority = 1000,
		config =
			function()
				vim.cmd.colorscheme 'onedark'
			end,
	},

	-- Set lualine as statusline
	{
		'nvim-lualine/lualine.nvim',
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = false,
				theme = 'onedark',
				component_separators = '|',
				section_separators = '',
			},
		},
	},


	-- Add indentation guides even on blank lines
	{
		'lukas-reineke/indent-blankline.nvim',
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help indent_blankline.txt`
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup({
			})
		end
	},


	-- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim',         opts = {} },

	-- Fuzzy Finder (files, lsp, etc)
	{ 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build =
		'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
	},

	-- Highlight, edit, and navigate code
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
			'nvim-treesitter/nvim-treesitter-context',
		},
		build = ':TSUpdate',
	},

	-- Toggle term
	{ 'akinsho/toggleterm.nvim', version = "*", config = true },

	-- Copilot
	-- { 'github/copilot.vim' },

	-- Codeium
	{
		'Exafunction/codeium.vim',
		event = 'BufEnter'
	},

	-- install without yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	}

}, {})
