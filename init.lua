-- Fix treesitter parser path not being in runtimepath
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site")

-- =============================================================================
-- OPTIONS
-- =============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- =============================================================================
-- KEYMAPS
-- =============================================================================
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Move between windows with Ctrl+hjkl (like VSCode Ctrl+arrows)
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Ensure +page.svelte and other svelte files are detected correctly
vim.filetype.add({
	extension = {
		svelte = "svelte",
	},
})

-- =============================================================================
-- BOOTSTRAP lazy.nvim
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- PLUGINS
-- =============================================================================
require("lazy").setup({

	-- ---------------------------------------------------------------------------
	-- Colorscheme
	-- ---------------------------------------------------------------------------
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},

	-- ---------------------------------------------------------------------------
	-- Fuzzy finder — live grep + file search (the Ctrl+P / Ctrl+Shift+F of nvim)
	-- ---------------------------------------------------------------------------
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					preview = {
						treesitter = false,
					},
				},
			})
			pcall(require("telescope").load_extension, "fzf")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
		end,
	},

	-- ---------------------------------------------------------------------------
	-- File explorer (press \ to open/close)
	-- ---------------------------------------------------------------------------
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{ "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
		},
		opts = {
			filesystem = {
				window = {
					mappings = { ["\\"] = "close_window" },
				},
			},
		},
	},

	-- ---------------------------------------------------------------------------
	-- Statusline
	-- ---------------------------------------------------------------------------
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "tokyonight",
			},
		},
	},

	-- ---------------------------------------------------------------------------
	-- Git signs in the gutter
	-- ---------------------------------------------------------------------------
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	-- ---------------------------------------------------------------------------
	-- Auto-close brackets/quotes
	-- ---------------------------------------------------------------------------
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	-- ---------------------------------------------------------------------------
	-- Highlight matching brackets
	-- ---------------------------------------------------------------------------
	{
		"utilyre/sentiment.nvim",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},

	-- ---------------------------------------------------------------------------
	-- Indentation guides
	-- ---------------------------------------------------------------------------
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},

	-- ---------------------------------------------------------------------------
	-- Treesitter — syntax highlighting + smart text objects
	-- ---------------------------------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter.config").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			-- Enable highlighting for all filetypes that have a parser
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})

			-- Install parsers only if missing
			local parsers = {
				"rust",
				"python",
				"svelte",
				"go",
				"javascript",
				"typescript",
				"html",
				"css",
				"lua",
				"vim",
				"vimdoc",
			}
			local installed = vim.fn.globpath(vim.fn.stdpath("data") .. "/site/parser", "*.so")
			for _, lang in ipairs(parsers) do
				if not installed:find(lang) then
					vim.cmd("TSInstall! " .. lang)
				end
			end
		end,
	},

	-- ---------------------------------------------------------------------------
	-- LSP — language servers (hover docs, go-to-def, rename, etc.)
	-- ---------------------------------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically installs language servers
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- Shared on-attach: keymaps that only make sense when an LSP is active
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					local tb = require("telescope.builtin")
					map("gd", tb.lsp_definitions, "[G]oto [D]efinition")
					map("gr", tb.lsp_references, "[G]oto [R]eferences")
					map("gI", tb.lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				end,
			})

			-- Servers to install and enable automatically
			require("mason-lspconfig").setup({
				ensure_installed = {
					"rust_analyzer", -- Rust
					"pyright", -- Python
					"svelte", -- Svelte
					"gopls", -- Go
					"ts_ls", -- TypeScript/JavaScript (used by Svelte files too)
					"cssls", -- CSS
					"html", -- HTML
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
					["lua_ls"] = function()
						require("lspconfig").lua_ls.setup({
							settings = {
								Lua = {
									runtime = { version = "LuaJIT" },
									workspace = {
										checkThirdParty = false,
										library = vim.api.nvim_get_runtime_file("", true),
									},
									diagnostics = { globals = { "vim" } },
									telemetry = { enable = false },
								},
							},
						})
					end,
				},
			})
		end,
	},

	-- ---------------------------------------------------------------------------
	-- Autocompletion
	-- ---------------------------------------------------------------------------
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP completions
			"hrsh7th/cmp-buffer", -- Words from current buffer
			"hrsh7th/cmp-path", -- File paths
			"L3MON4D3/LuaSnip", -- Snippet engine (required by cmp)
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},

	-- ---------------------------------------------------------------------------
	-- Formatter (runs on save)
	-- ---------------------------------------------------------------------------
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					rust = { "rustfmt" },
					python = { "ruff_format" },
					svelte = { "prettier" },
					go = { "gofmt" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
	},

	-- ---------------------------------------------------------------------------
	-- Which-key — shows available keymaps as you type (like VSCode's command palette hints)
	-- ---------------------------------------------------------------------------
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {},
	},
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
		},
	},
})
