return { -- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- Simple and easy statusline.
		--  You could remove this setup call if you don't like it,
		--  and try some other statusline plugin
		local statusline = require("mini.statusline")
		-- set use_icons to true if you have a Nerd Font
		statusline.setup({ use_icons = vim.g.have_nerd_font })

		-- You can configure sections in the statusline by overriding their
		-- default behavior. For example, here we set the section for
		-- cursor location to LINE:COLUMN
		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return "%2l:%-2v"
		end

		-- Indentation scope
		require("mini.indentscope").setup()

		-- Jump extented, f,F,t,T
		require("mini.jump").setup()

		-- Split-Join
		require("mini.splitjoin").setup({
			mappings = { toggle = "" },
		})
		vim.keymap.set(
			{ "n", "x" },
			"ıs",
			"<cmd>lua require('mini.splitjoin').split()<CR>",
			{ desc = "Split argumets" }
		)
		vim.keymap.set({ "n", "x" }, "ıj", "<cmd>lua require('mini.splitjoin').join()<CR>", { desc = "Join argumets" })

		-- mini file explorer
		require("mini.files").setup({
			-- mapping = {
			-- 	go_in = "<CR>",
			-- 	go_in_plus = "L",
			-- 	go_out = "-",
			-- 	go_out_plus = "H",
			-- },
		})

		vim.keymap.set(
			"n",
			"<leader>te",
			"<cmd>lua require('mini.files').open()<CR>",
			{ desc = "Toggle Mini File Explorer" }
		)
		vim.keymap.set("n", "<leader>tf", function()
			require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
			require("mini.files").reveal_cwd()
		end, { desc = "Toggle into currently opened file" })

		-- Clue, show keybindings
		-- local miniclue = require("mini.clue")
		-- miniclue.setup({
		-- 	triggers = {
		-- 		-- Leader triggers
		-- 		{ mode = "n", keys = "<Leader>" },
		-- 		{ mode = "x", keys = "<Leader>" },
		--
		-- 		-- Built-in completion
		-- 		{ mode = "i", keys = "<C-x>" },
		--
		-- 		-- `g` key
		-- 		{ mode = "n", keys = "g" },
		-- 		{ mode = "x", keys = "g" },
		--
		-- 		-- Marks
		-- 		{ mode = "n", keys = "'" },
		-- 		{ mode = "n", keys = "`" },
		-- 		{ mode = "x", keys = "'" },
		-- 		{ mode = "x", keys = "`" },
		--
		-- 		-- Registers
		-- 		{ mode = "n", keys = '"' },
		-- 		{ mode = "x", keys = '"' },
		-- 		{ mode = "i", keys = "<C-r>" },
		-- 		{ mode = "c", keys = "<C-r>" },
		--
		-- 		-- Window commands
		-- 		{ mode = "n", keys = "<C-w>" },
		--
		-- 		-- `z` key
		-- 		{ mode = "n", keys = "z" },
		-- 		{ mode = "x", keys = "z" },
		-- 	},
		--
		-- 	clues = {
		-- 		-- Enhance this by adding descriptions for <Leader> mapping groups
		-- 		miniclue.gen_clues.builtin_completion(),
		-- 		miniclue.gen_clues.g(),
		-- 		miniclue.gen_clues.marks(),
		-- 		miniclue.gen_clues.registers(),
		-- 		miniclue.gen_clues.windows(),
		-- 		miniclue.gen_clues.z(),
		-- 	},
		-- })
	end,
}
