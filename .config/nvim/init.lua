local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
require("opts")
vim.g.mapleader = " "
options = { noremap = true }
vim.api.nvim_set_keymap("n", "<leader>!", ":BaconLoad<CR>:w<CR>:BaconNext<CR>", options)
vim.api.nvim_set_keymap("n", "<leader>,", ":BaconList<CR>", options)
vim.api.nvim_set_keymap("n", "<leader>F", ":Telescope find_files hidden=true<cr>", options)
vim.api.nvim_set_keymap("n", "<leader>b", ":Telescope buffers<cr>", options)
vim.api.nvim_set_keymap("n", "<leader>f", ":Telescope find_files<cr>", options)
vim.api.nvim_set_keymap("n", "<leader>g", ":Neogit<cr>", options)
vim.api.nvim_set_keymap("n", "<leader>l", ":Telescope live_grep<cr>", options)
vim.api.nvim_set_keymap("n", "<leader>n", ":nohlsearch<cr>", options)
vim.api.nvim_set_keymap("n", "<leader>o", ":ObsidianQuickSwitch<cr>", options)

if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
	{
		"mistricky/codesnap.nvim",
		build = "make",
		keys = {
			{ "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
			{ "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
		},
		opts = {
			mac_window_bar = false,
			title = "CodeSnap.nvim",
			code_font_family = "CaskaydiaCove Nerd Font",
			watermark_font_family = "Pacifico",
			watermark = "&Thenceforth",
			bg_theme = "default",
			breadcrumbs_separator = "/",
			has_breadcrumbs = false,
			has_line_number = false,
			min_width = 0,
			save_path = "~/Pictures",
		},
	},
	{ "vlime/vlime" },
	{ "kovisoft/paredit" },
	{ "mattn/emmet-vim" },
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		--   "BufReadPre path/to/my-vault/**.md",
		--   "BufNewFile path/to/my-vault/**.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
			"epwalsh/pomo.nvim",
			"hrsh7th/nvim-cmp",
		},
		opts = {
			workspaces = {
				{
					name = "pro",
					path = "~/Documents/V2023",
				},
			},

			-- see below for full list of options 👇
		},
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	{ "github/copilot.vim" },
	{ "Canop/nvim-bacon" },
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
	},

	{ "williamboman/mason.nvim" },
	{ "mhartington/formatter.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		requires = { "nvim-lua/plenary.nvim" },
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
	},
}
require("lazy").setup(plugins, opts)
require("oil").setup()

local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>a", function()
	vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
	-- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })

-- Utilities for creating configurations
local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		lua = {
			-- "formatter.filetypes.lua" defines default configurations for the
			-- "lua" filetype
			require("formatter.filetypes.lua").stylua,

			-- You can also define your own configuration
			function()
				-- Supports conditional formatting
				if util.get_current_buffer_file_name() == "special.lua" then
					return nil
				end

				-- Full specification of configurations is down below and in Vim help
				-- files
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},

		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

vim.cmd("colorscheme catppuccin-mocha")
vim.cmd("set autoread | au CursorHold * checktime | call feedkeys('lh')")
require("obsidian").setup({
	workspaces = {
		{
			name = "pro",
			path = "~/Documents/V2023",
		},
	},

	-- see below for full list of options 👇
})
require("pomo").setup({
	-- How often the notifiers are updated.
	update_interval = 1000,

	-- Configure the default notifiers to use for each timer.
	-- You can also configure different notifiers for timers given specific names, see
	-- the 'timers' field below.
	notifiers = {
		-- The "Default" notifier uses 'vim.notify' and works best when you have 'nvim-notify' installed.
		{
			name = "Default",
			opts = {
				-- With 'nvim-notify', when 'sticky = true' you'll have a live timer pop-up
				-- continuously displayed. If you only want a pop-up notification when the timer starts
				-- and finishes, set this to false.
				sticky = true,

				-- Configure the display icons:
				title_icon = "󱎫",
				text_icon = "󰄉",
				-- Replace the above with these if you don't have a patched font:
				-- title_icon = "⏳",
				-- text_icon = "⏱️",
			},
		},

		-- The "System" notifier sends a system notification when the timer is finished.
		-- Available on MacOS natively and Linux via the `libnotify-bin` package.
		-- Tracking: https://github.com/epwalsh/pomo.nvim/issues/3
		{ name = "System" },

		-- You can also define custom notifiers by providing an "init" function instead of a name.
		-- See "Defining custom notifiers" below for an example 👇
		-- { init = function(timer) ... end }
	},

	-- Override the notifiers for specific timer names.
	timers = {
		-- For example, use only the "System" notifier when you create a timer called "Break",
		-- e.g. ':TimerStart 2m Break'.
		Break = {
			{ name = "System" },
		},
	},
})
local cmp = require("cmp")
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-.>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = "buffer" },
	}),
})
