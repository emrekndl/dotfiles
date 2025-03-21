return {
	"hkupty/iron.nvim",
	config = function(plugins, opts)
		local iron = require("iron.core")
		local view = require("iron.view")
		local common = require("iron.fts.common")

		iron.setup({
			config = {
				-- Whether a repl should be discarded or not
				scratch_repl = true,
				-- Your repl definitions come here
				repl_definition = {
					sh = {
						-- Can be a table or a function that
						-- returns a table (see below)
						command = { "zsh" },
					},
					python = {
						command = { "ipython" }, -- or { "ipython", "--no-autoindent" }
						format = common.bracketed_paste_python,
						block_deviders = { "# %%", "#%%" },
					},
				},
				-- set the file type of the newly created repl to ft
				-- bufnr is the buffer id of the REPL and ft is the filetype of the
				-- language being used for the REPL.
				repl_filetype = function(bufnr, ft)
					return ft
					-- or return a string name such as the following
					-- return "iron"
				end,
				-- How the repl window will be displayed
				-- See below for more information
				repl_open_cmd = view.right(40),
				-- repl_open_cmd = view.bottom(40),

				-- }
			},
			-- Iron doesn't set keymaps by default anymore.
			-- You can set them here or manually add keymaps to the functions in iron.core
			keymaps = {
				toggle_repl = "<space>ir",
				send_motion = "<space>ic",
				visual_send = "<space>ic",
				send_file = "<space>if",
				send_line = "<space>il",
				send_mark = "<space>im",
				mark_motion = "<space>imc",
				mark_visual = "<space>imc",
				remove_mark = "<space>imd",
				cr = "<space>i<cr>",
				interrupt = "<space>i<space>",
				exit = "<space>iq",
				clear = "<space>ix",
			},
			-- If the highlight is on, you can change how it looks
			-- For the available options, check nvim_set_hl
			highlight = {
				italic = true,
			},
			ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
		})

		-- iron also has a list of commands, see :h iron-commands for all available commands
		vim.keymap.set("n", "<space>is", "<cmd>IronRepl<cr>")
		vim.keymap.set("n", "<space>iR", "<cmd>IronRestart<cr>")
		vim.keymap.set("n", "<space>iF", "<cmd>IronFocus<cr>")
		vim.keymap.set("n", "<space>ih", "<cmd>IronHide<cr>")
	end,
}
