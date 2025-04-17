if vim.g.vscode then
	-- VSCode extension
	-- vim-options
	require("config.vim-options")
	-- keymaps
	require("config.keymaps")
	-- autocmds
	require("config.autocmds")
	-- lazy-nvim
	-- require("config.lazy")
else
	-- ordinary Neovim
	-- vim-options
	require("config.vim-options")
	-- keymaps
	require("config.keymaps")
	-- autocmds
	require("config.autocmds")
	-- lazy-nvim
	require("config.lazy")
end
