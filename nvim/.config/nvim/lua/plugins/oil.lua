return {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			copy_to_clipboard = true,
			watch_for_changes = true,
			columns = {
				"icon",
				"permissions",
				"size",
				-- "mtime",
				-- {
				-- 	"custom_name",
				-- 	function(entry)
				-- 		local depth = entry.depth or 0
				-- 		local indent = string.rep("  ", depth)
				-- 		return indent .. entry.name
				-- 	end,
				-- },
			},
			view_options = {
				show_hidden = true,
				natural_order = true,
				-- is_always_hidden = function(name, _)
				-- 	return name == ".." or name == ".git"
				-- end,
			},
			win_options = {
				wrap = true,
				-- signcolumn = "no",
				-- cursorcolumn = false,
				-- foldcolumn = "0",
				-- spell = false,
				-- list = false,
				-- conceallevel = 3,
				-- concealcursor = "nvic",
			},
		})
	end,
}
