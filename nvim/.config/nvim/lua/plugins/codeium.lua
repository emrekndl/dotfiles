return {
	-- {
	-- 	"Exafunction/codeium.nvim",
	-- 	cmd = "Codeium",
	-- 	event = "InsertEnter",
	-- 	build = ":Codeium Auth",
	-- 	opts = {
	-- 		enable_cmp_source = vim.g.ai_cmp,
	-- 		virtual_text = {
	-- 			enabled = not vim.g.ai_cmp,
	-- 			key_bindings = {
	-- 				accept = false,
	-- 				-- accept = "<M-Enter>",
	-- 				next = "<M-]>",
	-- 				prev = "<M-[>",
	-- 			},
	-- 		},
	-- 	},
	-- },
	{
		"monkoose/neocodeium",
		event = "VeryLazy",
		config = function()
			local neocodeium = require("neocodeium")
			local blink = require("blink.cmp")

			neocodeium.setup({
				show_label = false,
				silent = true,
				filter = function()
					return not blink.is_visible()
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "BlinkCmpMenuOpen",
				callback = function()
					neocodeium.clear()
				end,
			})
			vim.keymap.set("i", "<A-f>", neocodeium.accept)
			vim.keymap.set("i", "<A-w>", function()
				require("neocodeium").accept_word()
			end)
			-- vim.keymap.set("i", "<A-a>", function()
			-- 	require("neocodeium").accept_line()
			-- end)
			vim.keymap.set("i", "<A-e>", function()
				require("neocodeium").cycle_or_complete()
			end)
			-- vim.keymap.set("i", "<A-r>", function()
			-- 	require("neocodeium").cycle_or_complete(-1)
			-- end)
			vim.keymap.set("i", "<A-c>", function()
				require("neocodeium").clear()
			end)
		end,
	},
}
