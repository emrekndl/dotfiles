return {

	"saghen/blink.cmp",
	dependencies = {
		{ "mikavilpas/blink-ripgrep.nvim" },
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			dependencies = {
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					-- require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath 'config' .. '/snippets' } })

					local extends = {
						typescript = { "tsdoc" },
						javascript = { "jsdoc" },
						lua = { "luadoc" },
						python = { "pydoc" },
						rust = { "rustdoc" },
						-- cs = { 'csharpdoc' },
						java = { "javadoc" },
						c = { "cdoc" },
						cpp = { "cppdoc" },
						-- php = { 'phpdoc' },
						-- kotlin = { 'kdoc' },
						-- ruby = { 'rdoc' },
						sh = { "shelldoc" },
					}
					-- friendly-snippets - enable standardized comments snippets
					for ft, snips in pairs(extends) do
						require("luasnip").filetype_extend(ft, snips)
					end
				end,
			},
			opts = { history = true, delete_check_events = "TextChanged" },
		},
	},

	version = "*",
	opts = function(_, opts)
		opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
			default = { "lsp", "path", "snippets", "buffer", "ripgrep" },
			-- default = { "lsp", "path", "snippets", "buffer", "ripgrep", "dadbod" },
			-- default = { "lsp", "path", "snippets", "buffer", "luasnip"},
			providers = {
				lsp = {
					name = "lsp",
					enabled = true,
					module = "blink.cmp.sources.lsp",
					-- kind = "LSP",
					fallbacks = { "luasnip", "buffer" },
					score_offset = 90, -- the higher the number, the higher the priority
				},
				-- luasnip = {
				-- 	name = "luasnip",
				-- 	enabled = true,
				-- 	module = "blink.cmp.sources.luasnip",
				-- 	min_keyword_length = 2,
				-- 	fallbacks = { "snippets" },
				-- 	score_offset = 85,
				-- 	max_items = 8,
				-- },
				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					score_offset = 3,
					fallbacks = { "luasnip", "buffer" },
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
						end,
						show_hidden_files_by_default = true,
					},
				},
				buffer = {
					name = "Buffer",
					enabled = true,
					max_items = 3,
					module = "blink.cmp.sources.buffer",
					min_keyword_length = 4,
				},
				snippets = {
					name = "Snippets",
					enabled = true,
					max_items = 3,
					module = "blink.cmp.sources.snippets",
					min_keyword_length = 4,
					score_offset = 80, -- the higher the number, the higher the priority
				},
				ripgrep = {
					module = "blink-ripgrep",
					name = "Ripgrep",
					---@module "blink-ripgrep"
					---@type blink-ripgrep.Options
					opts = {
						prefix_min_len = 4,
						score_offset = 10, -- should be lower priority
						max_filesize = "300K",
						search_casing = "--smart-case",
					},
				},
				-- dadbod = {
				-- 	name = "Dadbod",
				-- 	module = "vim_dadbod_completion.blink",
				-- },
			},
		})

		opts.cmdline = {
			sources = function()
				local type = vim.fn.getcmdtype()
				if type == "/" or type == "?" then
					return { "buffer" }
				end
				if type == ":" then
					return { "cmdline" }
				end
				return {}
			end,
		}

		opts.snippets = {
			preset = "luasnip",
			-- preset = "friendly",
			expand = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return require("luasnip").jumpable(filter.direction)
				end
				return require("luasnip").in_snippet()
			end,
			jump = function(direction)
				require("luasnip").jump(direction)
			end,
		}

		opts.keymap = {
			preset = "default",
		}

		opts.appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
			highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
		}

		opts.completion = {
			keyword = { range = "full" },
			-- list = {
			-- 	selection = "auto_insert",
			-- },
			menu = {
				-- auto_show = function(ctx)
				-- 	return ctx.mode ~= "default"
				-- end,
				min_width = 25,
				max_height = 10,
				-- border = "single",
				border = "rounded",
				winblend = 0,
				-- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
				winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
				-- nvim.cmp style menu
				draw = {
					columns = {
						-- { "label", gap = 1 },
						-- { "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", gap = 1, "kind" },
					},
					treesitter = { "lsp" },
					components = {
						label = {
							width = { fill = true, max = 60 },
							text = function(ctx)
								local highlights_info = require("colorful-menu").blink_highlights(ctx)
								if highlights_info ~= nil then
									-- Or you want to add more item to label
									return highlights_info.label
								else
									return ctx.label
								end
							end,
							highlight = function(ctx)
								local highlights = {}
								local highlights_info = require("colorful-menu").blink_highlights(ctx)
								if highlights_info ~= nil then
									highlights = highlights_info.highlights
								end
								for _, idx in ipairs(ctx.label_matched_indices) do
									table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
								end
								-- Do something else
								return highlights
							end,
							-- text = function(ctx)
							-- 	local highlights_info =
							-- 		require("colorful-menu").highlights(ctx.item, vim.bo.filetype)
							-- 	if highlights_info ~= nil then
							-- 		return highlights_info.text
							-- 	else
							-- 		return ctx.label
							-- 	end
							-- end,
							-- highlight = function(ctx)
							-- 	local highlights_info =
							-- 		require("colorful-menu").highlights(ctx.item, vim.bo.filetype)
							-- 	local highlights = {}
							-- 	if highlights_info ~= nil then
							-- 		for _, info in ipairs(highlights_info.highlights) do
							-- 			table.insert(highlights, {
							-- 				info.range[1],
							-- 				info.range[2],
							-- 				group = ctx.deprecated and "BlinkCmpLabelDeprecated" or info[1],
							-- 			})
							-- 		end
							-- 	end
							-- 	for _, idx in ipairs(ctx.label_matched_indices) do
							-- 		table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
							-- 	end
							-- 	return highlights
							-- end,
						},
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
				treesitter_highlighting = true,
				window = {
					min_width = 20,
					max_width = 90,
					max_height = 25,
					border = "rounded",
					-- border = "padded",
					winblend = 0,
					-- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
				},
			},
			ghost_text = {
				enabled = true,
				-- enabled = vim.g.ai_cmp,
			},
		}

		opts.signature = {
			enabled = true,
			window = {
				min_width = 1,
				max_width = 100,
				max_height = 10,
				border = "rounded",
				-- border = "padded",
				winblend = 0,
				-- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
			},
		}

		return opts
	end,
	opts_extend = { "sources.default" },
}
