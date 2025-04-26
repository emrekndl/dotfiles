return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	-----@module 'render-markdown'
	-----@type render.md.UserConfig
	config = function()
		require("render-markdown").setup({
			render_modes = { "n", "c", "t" },
			-- only_render_image_at_cursor = true,
			code = {
				style = "language",
			},
		})
	end,
}
