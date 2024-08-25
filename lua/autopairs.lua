-- File: ~/.config/nvim/lua/autopairs.lua

local M = {}

function M.setup()
	-- Install the plugin using lazy.nvim
	require("lazy").setup({
		{
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({
					disable_filetype = { "TelescopePrompt", "vim" },
					check_ts = true, -- Enable treesitter integration
				})
			end,
			event = "InsertEnter", -- Load on entering insert mode
		},
	})
end

return M
