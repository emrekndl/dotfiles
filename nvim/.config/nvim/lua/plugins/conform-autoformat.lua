return {
	"stevearc/conform.nvim",
	lazy = false,
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		-- format_on_save = false,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = true, cpp = true }
			return {
				timeout_ms = 500,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			-- python = function(bufnr)
			-- 	if require("conform").get_formatter_info("ruff", bufnr).available then
			-- 		return { "ruff" }
			-- 	else
			-- 		return { ruff"black", "isort" }
			-- 	end
			-- end,
			python = { "pylsp" },
			-- python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
			go = { "gofmt" },
			html = { "prettier" },
			javascript = { { "prettier" } },
			typescript = { { "prettier" } },
			css = { "prettier" },
			json = { "prettier" },
			markdown = { "prettier" },
			yaml = { "prettier" },
			toml = { "prettier" },
			cpp = { "clangd" },
			c = { "clangd" },
		},
	},
}
