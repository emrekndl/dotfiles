if vim.g.vscode then
	-- VSCode extension
	-- vim-options
	require("config.vim-options")
else
	-- ordinary Neovim
	-- vim-options
	require("config.vim-options")
	-- lazy-nvim
	require("config.lazy")
end
