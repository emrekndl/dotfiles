return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		-- ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "heex", "javascript", "html", "go", "python", "java" },
		auto_install = true,
		-- sync_install = false,
		highlight = { enable = true },
		indent = { enable = true },
	},
}
