return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.formatting.prettier,
				-- null_ls.builtins.formatting.djlint,
				-- null_ls.builtins.formatting.black,
				-- null_ls.builtins.formatting.isort,
				require("none-ls.diagnostics.eslint_d"),
				-- require("none-ls.diagnostics.gofmt"),
				-- require("none-ls.diagnostics.golint"),
				require("none-ls.diagnostics.ruff"),
				-- require("none-ls.code_actions.ruff"),
				-- null_ls.builtins.diagnostics.gofmt,
				-- null_ls.builtins.diagnostics.golint,
				-- null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.diagnostics.mypy,
				null_ls.builtins.diagnostics.djlint,
				-- null_ls.builtins.diagnostics.ruff,
				-- null_ls.builtins.code_actions.ruff,
				null_ls.builtins.code_actions.refactoring,
			},
		})
	end,
}
