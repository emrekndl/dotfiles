return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{
				"j-hui/fidget.nvim",
				config = function()
					require("fidget").setup({
						progress = { -- LSP
							ignore = { "null-ls" },
						},
						notification = {
							window = {
								winblend = 0,
								-- border = "rounded",
							},
						},
					})
				end,
			},

			-- used for completion, annotations and signatures of Neovim apis
			-- { "folke/neodev.nvim", opts = {} },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					-- map("gr", function()
					-- 	vim.lsp.buf.references({ includeDeclaration = true })
					-- 	vim.cmd("copen") -- Quickfix window open
					-- end, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- Opens a popup that displays documentation about the word under your cursor
					--  See `:help K` for why this keymap.
					map("K", vim.lsp.buf.hover, "Hover Documentation")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
			-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.

			local cwd = vim.fn.getcwd()

			local python_version = function()
				local venv_path = cwd .. "/.venv/bin/python"
				if vim.fn.executable(venv_path) == 1 then
					local version = vim.fn.system(venv_path .. " --version")
					return version:match("Python%s+(%d+%.%d+)")
				end
				return "3.11"
			end

			local venv_site_packages = cwd .. "/.venv/lib/python" .. python_version() .. "/site-packages"

			local servers = {
				clangd = {
					cmd = { "clangd", "--background-index" },
					filetypes = { "c", "cpp", "h", "cc", "objc", "objcpp" },
					root_dir = require("lspconfig/util").root_pattern(
						".clangd",
						".clang-tidy",
						".clang-format",
						"compile_commands.json",
						"compile_flags.txt",
						"configure.ac",
						".git"
					),
					single_file_support = true,
					settings = {
						capabilities = {
							textDocument = {
								completion = {
									completionItem = {
										snippetSupport = true,
									},
								},
							},
						},
					},
				},
				-- ts_ls = {
				-- 	cmd = { "typescript-language-server", "--stdio" },
				-- 	filetypes = {
				-- 		"javascript",
				-- 		"javascriptreact",
				-- 		"javascript.jsx",
				-- 		"typescript",
				-- 		"typescriptreact",
				-- 		"typescript.tsx",
				-- 	},
				-- 	root_dir = require("lspconfig/util").root_pattern(
				-- 		"package.json",
				-- 		"tsconfig.json",
				-- 		"jsconfig.json",
				-- 		".git"
				-- 	),
				-- 	single_file_support = true,
				-- 	settings = {
				-- 		capabilities = {
				-- 			textDocument = {
				-- 				completion = {
				-- 					completionItem = {
				-- 						snippetSupport = true,
				-- 					},
				-- 				},
				-- 			},
				-- 		},
				-- 	},
				-- },
				-- tailwindcss = {
				-- 	cmd = { "tailwindcss-language-server", "--stdio" },
				-- 	filetypes = {
				-- 	},
				-- 	settings = {
				-- 		tailwindCSS = {
				-- 			classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
				-- 			validate = true,
				-- 		},
				-- 	},
				-- },
				gopls = {
					settings = {
						gopls = {
							-- gofumpt = true,    -- gofumpt ile daha katı biçimlendirme kuralları
							-- experimentalWorkspaceModule = true,  -- Birden fazla modül ile çalışma
							usePlaceholders = true, -- Tamamlayıcılarda yer tutucular kullanır
							completeUnimported = true, -- İmport edilmemiş paketleri tamamlar
							staticcheck = true, -- Staticcheck aracı ile ekstra kontroller yapar
							matcher = "fuzzy", -- Fuzzy match (bulanık eşleşme) tamamlama
							analyses = {
								unusedparams = true, -- Kullanılmayan parametreler için uyarı verir
								shadow = true, -- Değişken gölgelemesi için analiz
							},
							codelenses = {
								generate = true, -- Kod lensi ile kod üretme
								gc_details = true, -- Çöp toplama detaylarını gösterme
							},
						},
					},
					completion = {
						usePlaceholders = true,
						completeUnimported = true,
					},
					capabilities = {
						textDocument = {
							completion = {
								completionItem = {
									snippetSupport = true,
								},
							},
						},
					},
				},
				pylsp = {
					settings = {
						pylsp = {
							executable = "pylsp",
							plugins = {
								rope_autoimport = {
									enabled = false,
									-- extra_paths = { venv_site_packages },
								},
								ruff = {
									enabled = true, -- Enable the plugin
									formatEnabled = true, -- Enable formatting using ruffs formatter
									executable = "ruff",
									extendSelect = { "I" }, -- Rules that are additionally used by ruff
									extendIgnore = { "C90" }, -- Rules that are additionally ignored by ruff
									format = { "I" }, -- Rules that are marked as fixable by ruff that should be fixed when running textDocument/formatting
									severities = { ["D212"] = "I" }, -- Optional table of rules where a custom severity is desired
									unsafeFixes = false, -- Whether or not to offer unsafe fixes as code actions. Ignored with the "Fix All" action

									lineLength = 88, -- Line length to pass to ruff checking and formatting
									exclude = { "__about__.py" }, -- Files to be excluded by ruff checking
									select = { "F" }, -- Rules to be enabled by ruff
									ignore = { "D210" }, -- Rules to be ignored by ruff
									perFileIgnores = { ["__init__.py"] = "CPY001" }, -- Rules that should be ignored for specific files
									preview = false, -- Whether to enable the preview style linting and formatting.
									targetVersion = "py310",
								},
								pyflakes = {
									enabled = false,
								},
								pycodestyle = {
									enabled = false,
								},
								autopep8 = {
									enabled = false,
								},
								yapf = {
									enabled = false,
								},
								mccabe = {
									enabled = false,
								},
								pylsp_black = {
									enabled = false,
								},
								pylsp_mypy = {
									enabled = false,
								},
								pylsp_isort = {
									enabled = false,
								},
							},
						},
					},
				},
				-- pyright = {
				-- 	settings = {
				-- 		disableOrganizeImports = true,
				-- 		python = {
				-- 			analysis = {
				-- 				ignore = { "*" },
				-- 			},
				-- 			-- 	analysis = {
				-- 			-- 		autoSearchPaths = true,
				-- 			-- 		useLibraryCodeForTypes = true,
				-- 			-- 		diagnosticMode = "workspace",
				-- 			-- 		autoImportCompletions = true,
				-- 			-- 		extraPaths = { venv_site_packages },
				-- 			-- 		disableOrganizeImports = true,
				-- 			-- 	},
				-- 		},
				-- 	},
				-- capabilities = {
				-- 	textDocument = {
				-- 		completion = {
				-- 			completionItem = {
				-- 				snippetSupport = true,
				-- 				resolveSupport = {
				-- 					properties = { "documentation", "detail", "additionalTextEdits" },
				-- 				},
				-- 			},
				-- 		},
				-- 	},
				-- },
				-- },
				-- rust_analyzer = {},
				-- tsserver = {},

				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				-- "stylua",
				-- "pyright",
				-- "gopls",
				-- "ts_ls",
				-- "tailwindcss",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = ensure_installed,
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = { "lua", "python", "go" },
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
				{ path = vim.fn.getcwd() .. "/venv/lib/python3.x/site-packages", words = { "import", "from", "as" } },
				{ path = vim.fn.getcwd() .. "/src", words = { "import" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
}
