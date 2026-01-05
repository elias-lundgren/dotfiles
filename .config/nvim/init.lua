vim.pack.add({
	{ src = "https://github.com/folke/lazy.nvim", version = "85c7ff3711b730b4030d03144f6db6375044ae82" },
})

require("lazy").setup({
	spec = {
		{
			url = "https://github.com/nvim-tree/nvim-tree.lua",
			cmd = { "NvimTreeToggle", "NvimTreeFocus" },
			commit = "321bc61580fd066b76861c32de3319c3a6d089e7",
			opts = require("config/nvim-tree"),
		},
		{
			url = "https://github.com/nvim-treesitter/nvim-treesitter",
      lazy = false,
			commit = "42fc28ba918343ebfd5565147a42a26580579482",
      build = ":TSUpdate",
			opts = require("config/treesitter"),
		},
		{
			url = "https://github.com/mason-org/mason.nvim",
			cmd = { "Mason", "MasonInstall", "MasonUpdate" },
			commit = "ad7146aa61dcaeb54fa900144d768f040090bff0",
			opts = {},
		},
		{
			url = "https://github.com/neovim/nvim-lspconfig",
			commit = "d20d83b3f24f5884da73a9fc92fdc47e778b8d0d",
			config = function()
				require("lsp")
			end,
		},
		{
			url = "https://github.com/mason-org/mason-lspconfig.nvim",
			commit = "f2fa60409630ec2d24acf84494fb55e1d28d593c",
			opts = {},
		},
		{
			url = "https://github.com/saghen/blink.cmp",
			event = "InsertEnter",
			commit = "ceed1545929b74cf79b5a8950e7c415683bf690b",
			opts = require("config/blink"),
		},
		{
			url = "https://github.com/nvim-telescope/telescope.nvim",
			cmd = "Telescope",
			commit = "e709d31454ee6e6157f0537f861f797bd44c0bad",
			opts = function()
				return require("config/telescope")
			end,
			config = function(_, opts)
				require("telescope").setup(opts)
				require("telescope").load_extension("cmdline")
			end,
			dependencies = {
				{
					url = "https://github.com/jonarrien/telescope-cmdline.nvim",
					commit = "b1c330835563c9628ce7c095cf20772f22f93f07",
				},
			},
		},
		{
			url = "https://github.com/nvim-mini/mini.misc",
			event = "BufReadPost",
			commit = "b647b64321c34d4868d158282bb89e49f0d6838b",
			config = function()
				require("mini.misc").setup_auto_root()
			end,
		},
		{
			url = "https://github.com/branchgrove/conform.nvim",
			cmd = "Format",
			config = function()
				require("conform").setup(require("config/conform"))
			end,
		},
	},
})

require("options")
require("mappings")
require("highlights")

vim.api.nvim_create_autocmd({ "BufRead" }, {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
