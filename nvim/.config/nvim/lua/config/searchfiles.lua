local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

local M = {}

local search_files_with_location = function(opts)
	opts = opts or {}
	opts.cwd = opts.cwd or vim.uv.cwd()

	local finder = finders.new_async_job({
		NEW_CWD = opts.cwd,
		command_generator = function(prompt)
			if not prompt or prompt == "" then
				return nil
			end

			local pieces = vim.split(prompt, "  ")
			local args = { "rg" }

			if pieces[1] then
				table.insert(args, "-g")
				-- table.insert(args, "-e")
				table.insert(args, pieces[1])
			end

			-- if pieces[2] then
			-- 	table.insert(args, "-g")
			-- 	table.insert(args, pieces[2])
			-- 	-- table.insert(args, "*." .. pieces[2])
			-- end

			NEW_CWD = pieces[2] or vim.fn.getcwd()
			local cwd = pieces[2] or vim.fn.getcwd()
			table.insert(args, cwd)
			-- print(vim.inspect(NEW_CWD))
			-- print(vim.inspect(args))

			return vim.list_extend(args, {
				"--files",
				"--hidden",
				"--glob",
				"!**/.git/*",
				"--sortr=modified",
				-- "--color=never",
				-- "--no-heading",
				-- "--with-filename",
				-- "--line-number",
				-- "--column",
				-- "--smart-case",
			})
		end,

		entry_maker = make_entry.gen_from_vimgrep(opts),
		print(vim.inspect(NEW_CWD)),
		cwd = opts.cwd,
	})

	pickers
		.new(opts, {
			debounce = 101,
			prompt_title = "Search Files by Name and Location",
			finder = finder,
			previewer = conf.grep_previewer(opts),
			sorter = require("telescope.sorters").empty(),
		})
		:find()
end

M.setup = function()
	-- vim.keymap.set("n", "<leader>sc", function()
	-- 	search_files_with_location({ cwd = vim.fn.getcwd() })
	-- end, { desc = "[S]earch [F]iles by [L]ocation" })
end

return M
