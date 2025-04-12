-- highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
		-- vim.highlight.on_yank()
	end,
})

-- all float window add a border
vim.api.nvim_create_autocmd("WinNew", {
	callback = function()
		local win_id = vim.api.nvim_get_current_win()
		local config = vim.api.nvim_win_get_config(win_id)
		if config.relative ~= "" then
			vim.api.nvim_win_set_config(win_id, {
				border = "rounded", -- Border: 'rounded', 'single', 'double', 'solid', 'shadow'
			})
		end
	end,
})

-- navic lazy update context
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("nvim-navic", {}),
	callback = function()
		if vim.api.nvim_buf_line_count(0) > 10000 then
			vim.b.navic_lazy_update_context = true
		end
	end,
})
