return {
	"olivercederborg/poimandres.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("poimandres").setup({
			disable_background = true,
			disable_float_background = false,
			disable_italics = false,
			highlight_groups = {
				LspReferenceText = { bg = require("poimandres.palette").background1 },
				LspReferenceRead = { bg = require("poimandres.palette").background1 },
				LspReferenceWrite = { bg = require("poimandres.palette").background1 },
			},
		})

		vim.cmd("colorscheme poimandres")
	end,
}
