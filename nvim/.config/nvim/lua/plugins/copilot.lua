return {
	{
		"github/copilot.vim",
		event = "InsertEnter",
		lazy = false,
		autoStart = true,
		init = function()
			vim.g.copilot_workspace_folders = { vim.fn.getcwd() }
		end,
        enabled = false,
	-- config = function()
		--   vim.g.copilot_assume_mapped = true
		--   vim.api.nvim_set_keymap("i", "<C-L>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
		--   vim.g.copilot_no_tab_map = true
		-- end,
	},
}
