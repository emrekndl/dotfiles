return {
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
		config = function()
			vim.opt.updatetime = 200
			require("barbecue").setup({
				-- create_autocmd = false,
				show_modified = false,
				show_dirname = false,
				show_basename = false,
				theme = "auto",
				-- max_width = 80,
				-- theme = {
				-- normal = { fg = "#A6ACCD" }, -- blueGray1
				-- ellipsis = { fg = "#767C9D" }, -- blueGray2
				-- separator = { fg = "#767C9D" }, -- blueGray2
				-- modified = { fg = "#F96E2A" }, -- orange1
				--
				-- dirname = { fg = "#506477" }, -- blueGray3
				-- basename = { fg = "#89DDFF", bold = true }, -- blue1
				-- context = {},
				--
				-- context_file = { fg = "#ADD7FF" }, -- blue2
				-- context_class = { fg = "#42675A" }, -- teal3
				-- context_function = { fg = "#FAB12F" }, -- orange2
				-- context_variable = { fg = "#85A98F" }, -- green3
				-- context_constant = { fg = "#FAB12F" }, -- orange2
				-- context_string = { fg = "#FA4032" }, -- red1
				-- context_number = { fg = "#79BD8F" }, -- green5
				-- context_boolean = { fg = "#FAB12F" }, -- orange2
				-- context_array = { fg = "#FA4032" }, -- red1
				-- context_object = { fg = "#5FB3A1" }, -- teal2
				-- context_key = { fg = "#FAB12F" }, -- orange2
				-- context_enum = { fg = "#5FB3A1" }, -- teal2
				-- context_operator = { fg = "#FAB12F" }, -- orange2
				-- },
			})
			vim.keymap.set("n", "<leader>tc", function()
				require("barbecue.ui").toggle()
			end, { desc = "[T]oggle [B]arbecue" })
		end,
	},
}
