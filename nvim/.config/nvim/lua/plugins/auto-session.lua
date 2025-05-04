return {
	"rmagatti/auto-session",
	lazy = false,

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		auto_restore_enabled = false,
		suppressed_dirs = { "~/", "~/Downloads", "/" },
		allowed_dirs = { "~/dotfiles", "~/dev", "~/.config" },
		-- log_level = 'debug',
		cwd_change_handling = true,
		bypass_save_filetypes = { "alpha" },
	},
	keys = {
		{ "<leader>wr", "<cmd>SessionSave<cr>", desc = "Save Session" },
		{ "<leader>wl", "<cmd>SessionRestore<cr>", desc = "Load Session" },
	},
}
