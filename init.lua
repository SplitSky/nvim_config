-- init.lua

-- Load core settings
require("settings")

-- Load plugins
require("plugins")

-- Load keybindings
require("keybindings")

-- Load LSP configurations
require("lsp_config")

-- Load Autocommands
require("autocmds")

-- Load Themes and Appearance
require("themes")

-- Load language-specific configurations
require("languages.python")
require("languages.typescript")
require("languages.cpp")
require("languages.svelte")
