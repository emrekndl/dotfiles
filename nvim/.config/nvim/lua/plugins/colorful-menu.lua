return {
	"xzbdmw/colorful-menu.nvim",
	config = function()
		require("colorful-menu").setup({
			ft = {
				lua = {
					-- Maybe you want to dim arguments a bit.
					auguments_hl = "@comment",
				},
				typescript = {
					-- Or "vtsls", their information is different, so we
					-- need to know in advance.
					ls = "typescript-language-server",
				},
				rust = {
					-- such as (as Iterator), (use std::io).
					extra_info_hl = "@comment",
				},
				c = {
					-- such as "From <stdio.h>"
					extra_info_hl = "@comment",
				},
	               go = {
	                   -- such as "From <fmt>"
	                   extra_info_hl = "@comment",
	               },
	               python = {
	                   -- such as "From <os>"
	                   extra_info_hl = "@comment",
	               },
	               javascript = {
	                   -- such as "From <fs>"
	                   extra_info_hl = "@comment",
	               },
	               html = {
	                   -- such as "From <div>"
	                   extra_info_hl = "@comment",
	               },
	               css = {
	                   -- such as "From <div>"
	                   extra_info_hl = "@comment",
	               },
	               tailwindcss = {
	                   -- such as "From <div>"
	                   extra_info_hl = "@comment",
	               },
			},
			-- If the built-in logic fails to find a suitable highlight group,
			-- this highlight is applied to the label.
			fallback_highlight = "@variable",
			-- If provided, the plugin truncates the final displayed text to
			-- this width (measured in display cells). Any highlights that extend
			-- beyond the truncation point are ignored. Default 60.
			max_width = 60,
		})
	end,
}
