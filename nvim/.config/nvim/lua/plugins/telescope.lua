return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						n = {
							["d"] = require("telescope.actions").delete_buffer,
						},
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						-- find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
						-- find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--sortr=modified" },
						theme = "ivy",
					},
				},
				path_display = {
					filenmame_first = {
						reverse_directories = true,
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
					-- fzf = {
					-- 	fuzzy = true,
					-- 	override_generic_sorter = true,
					-- 	override_file_sorter = true,
					-- 	case_mode = "smart_case",
					-- },
					-- ["frecency"] = {
					--     auto_validate = false,
					--     path_display = { "filename_first" },
					-- },
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			pcall(require("telescope").load_extension, "frecency")

			-- local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			-- vim.keymap.set("n", "<leader>sf", function()
			--     local cwd = vim.fn.getcwd()
			--     require("telescope").extensions.frecency.frecency(require("telescope.themes").get_ivy({
			--     workspace = "CWD",
			--     cwd = cwd,
			--     prompt_title = "Search Files " .. cwd,}))
			-- end, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sf", function()
				builtin.find_files({
					-- frecency = true,
					hidden = true,
				})
			end, { desc = "[S]earch [F]iles" })
			-- vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			-- vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", function()
				builtin.oldfiles(require("telescope.themes").get_ivy({
					prompt_title = "Search Recent Files",
				}))
			end, { desc = '[S]earch Recent Files ("." for repeat)' })
			-- vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", function()
				builtin.buffers({
					sort_mru = true,
					sort_lastused = true,
					initial_mode = "normal",
					frecency = true,
				})
			end, { desc = "[ ] Find existing buffers" })
			-- vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })

			-- multigrep for searching multiple patterns
			require("config.multigrep").setup()

			vim.keymap.set("n", "<leader>ep", function()
				require("telescope.builtin").find_files({
					prompt_title = "Find Project File",
					cwd = vim.fs.joinpath("lazy", vim.fn.stdpath("data")),
				})
			end, { desc = "[E]dit [P]roject file" })

			-- vim.keymap.set("n", "<leader>sa", function()
			-- 	require("telescope.builtin").find_files({
			-- 		prompt_title = "Search All Files",
			-- 		cwd = "/",
			-- 	})
			-- end, { desc = "[S]earch [A]ll Files" })

			-- vim.keymap.set("n", "<leader>sa", function()
			-- 	require("telescope.builtin").find_files({
			-- 		prompt_title = "Search Home Files by Name and Extension",
			-- 		cwd = os.getenv("HOME"),
			-- 		prompt = function(prompt)
			-- 			local pieces = vim.split(prompt, "  ")
			-- 			if pieces[2] then
			-- 				return "*." .. pieces[2]
			-- 			else
			-- 				return ""
			-- 			end
			-- 		end,
			-- 	})
			-- end, { desc = "[S]earch [H]ome [F]iles" })

			-- search files by name, extension, and location
			-- require("config.searchfiles").setup()
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		version = "*",
		config = function()
			require("telescope").setup({
				extensions = {
					frecency = {
						auto_validate = false,
						matcher = "fuzzy",
						path_display = { "filename_first" },
					},
				},

				auto_validate = true,
				ignore_patterns = { "*/.git", "*/.git/*", "*/.DS_Store" },
			})
			require("telescope").load_extension("frecency")
		end,
	},
}
