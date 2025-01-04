return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "heex", "javascript", "html", "go", "python", "java", "json", "css", "typescript", "tsx", "rust", "cpp", "bash", "dockerfile", "graphql", "yaml" },
		auto_install = true,
		-- sync_install = false,
		highlight = { enable = true },
		indent = { enable = true },
	},
}
