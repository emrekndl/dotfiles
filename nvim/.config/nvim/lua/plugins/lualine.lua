return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		theme = "poimandres",
		icons_enabled = true,
		-- component_separators = { left = "", right = "" },
		-- section_separators = { left = "", right = "" },
		-- color palette
		-- yellow1 = '#FFFAC2',
		-- yellow2 = '#FFE31A',
		-- teal1 = '#5DE4C7',
		-- teal2 = '#5FB3A1',
		-- teal3 = '#42675A',
		-- teal4 = '#219B9D',
		-- teal5 = '#61D2B4',
		-- blue1 = '#89DDFF',
		-- blue2 = '#ADD7FF',
		-- blue3 = '#91B4D5',
		-- blue4 = '#7390AA',
		-- blue5 = '#10375C',
		-- blue6 = '#257180',
		-- blue7 = '#0A5EB0',
		-- blue7 = '#295F98',
		-- blue8 = '#78B3CE',
		-- pink1 = '#FAE4FC',
		-- pink2 = '#FCC5E9',
		-- pink3 = '#D0679D',
		-- red1 = "#FA4032"
		-- red2 = "#AE445A"
		-- orange1 = "#F96E2A"
		-- orange2 = "#FAB12F"
		-- green1 = "#9ABF80"
		-- green2 = "#3D5300"
		-- green3 = "#85A98F"
		-- green4 = "#525B44"
		-- green5 = "#79BD8F"
		-- blueGray1 = '#A6ACCD',
		-- blueGray2 = '#767C9D',
		-- blueGray3 = '#506477',
		-- blueGray4 = '#222831',
		-- background1 = '#303340',
		-- background2 = '#1B1E28',
		-- background3 = '#171922',
		-- text = '#E4F0FB',
		-- white = '#FFFFFF',
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 80,
			tabline = 100,
			winbar = 100,
		},

		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				{ "branch" },
				{
					"diff",
					colered = true,
					diff_color = {
						added = { fg = "#5DE4C7" },
						modified = { fg = "#FAB12F" },
						removed = { fg = "#D0679D" },
					},
					source = "auto",
				},
				{ "diagnostics" },
			},
			lualine_c = { { "filename", color = { gui = "bold" }, file_status = true, path = 3, shorting_target = 40 } },
			lualine_x = {
				{ "encoding", show_bomb = false, color = { fg = "#42675A" } },
				{ "filetype", colored = true, icons_only = false, color = { gui = "bold" } },
				{ "fileformat" },
				{ "serchcount", color = { fg = "#5FB3A1" } },
			},
			lualine_y = { { "filesize", color = { fg = "#79BD8F" } }, "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {
			lualine_a = {
				{
					"buffers",
					show_filename_only = true,
					hide_filename_extension = false,
					show_modified_status = true,

					mode = 2,
					-- 0: Shows buffer name
					-- 1: Shows buffer index
					-- 2: Shows buffer name + buffer index
					-- 3: Shows buffer number
					-- 4: Shows buffer name + buffer number

					max_length = vim.o.columns * 2 / 3,
					filetype_names = {
						TelescopePrompt = "Telescope",
						dashboard = "Dashboard",
						packer = "Packer",
						fzf = "FZF",
						alpha = "Alpha",
						netrw = "Netrw Explorer",
						oil = "Oil File Explorer",
					},

					use_mode_colors = false,

					-- buffers_color = {
					-- 	-- Same values as the general color option can be used here.
					-- 	active = "lualine_{section}_normal", -- Color for active buffer.
					-- 	inactive = "lualine_{section}_inactive", -- Color for inactive buffer.
					-- },

					symbols = {
						modified = " ●",
						alternate_file = "#",
						directory = "",
					},
				},
			},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		winbar = {},
		inactive_winbar = {},
		extensions = { "nvim-tree", "quickfix", "toggleterm", "trouble", "nvim-dap-ui", "fugitive", "lazy", "fzf" },
	},
}
