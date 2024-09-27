return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			build = function()
				return "make install_jsregexp"
			end,
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
		},
		"saadparwaiz1/cmp_luasnip", -- LuaSnip ile entegrasyon
		"hrsh7th/cmp-nvim-lsp", -- LSP için tamamlamalar
		"hrsh7th/cmp-path", -- Dosya yolu tamamlamaları
		"hrsh7th/cmp-buffer", -- Mevcut tamponlar için tamamlamalar
		"onsails/lspkind.nvim", -- LSP sembollerini daha okunur hale getirir
		-- "SirVer/ultisnips", -- UltiSnips eklentisi
		-- "quangnguyen30192/cmp-nvim-ultisnips", -- UltiSnips ile entegrasyon
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		luasnip.config.setup({
			history = true, -- Snippet geçmişini tutar
			update_events = "TextChanged,TextChangedI", -- Snippet güncellemelerini tetikler
		})

		cmp.setup({
			snippet = {
				expand = function(args)
					-- vim.fn["UltiSnips#ExpandSnippet"]()
					luasnip.lsp_expand(args.body)
				end,
			},
			formatting = {
				format = lspkind.cmp_format({
					with_text = true,
					menu = {
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						path = "[Path]",
						-- ultisnips = "[UltiSnip]", -- UltiSnips için simgeler
					},
					fields = { "kind", "abbr", "menu" },
					expandable_indicator = function(_, vim_item)
						return vim_item.kind .. " " .. (vim_item.expandable and ">" or "")
					end,
				}),
			},
			completion = { completeopt = "menu,menuone,noinsert" },
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			mapping = cmp.mapping.preset.insert({
				-- Select the [n]ext item
				["<C-n>"] = cmp.mapping.select_next_item(),
				-- Select the [p]revious item
				["<C-p>"] = cmp.mapping.select_prev_item(),

				-- Scroll the documentation window [b]ack / [f]orward
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),

				-- Accept ([y]es) the completion.
				--  This will auto-import if your LSP supports it.
				--  This will expand snippets if the LSP sent a snippet.
				["<C-y>"] = cmp.mapping.confirm({ select = true }),

				-- Manually trigger a completion from nvim-cmp.
				--  Generally you don't need this, because nvim-cmp will display
				--  completions whenever it has completion options available.
				["<C-Space>"] = cmp.mapping.complete({}),

				-- Think of <c-l> as moving to the right of your snippet expansion.
				--  So if you have a snippet that's like:
				--  function $name($args)
				--    $body
				--  end
				--
				-- <c-l> will move you to the right of each of the expansion locations.
				-- <c-h> is similar, except moving you backwards.
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			}),
			sources = {
				{ name = "nvim_lsp" }, -- LSP tamamlamaları
				{ name = "luasnip" }, -- LuaSnip tamamlamaları
				-- { name = "ultisnips" }, -- UltiSnips tamamlamaları
				{ name = "path" }, -- Dosya yolu tamamlamaları
				{ name = "buffer" }, -- Mevcut tamponlar için tamamlamalar
				{ name = "lazydev", group_index = 0 }, -- LazyDev tamamlamaları
			},
		})
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})
		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			-- matching = { disallow_symbol_nonprefix_matching = false },
		})
	end,
}
