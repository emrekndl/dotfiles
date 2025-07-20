return {
	"AndrewRadev/switch.vim",
	keys = {
		{ "gs", nil, { "n", "v" } },
	},
	config = function()
		local fk = [=[\<\(\l\)\(\l\+\(\u\l\+\)\+\)\>]=]
		local fv = [=[\=toupper(submatch(1)) . submatch(2)]=]
		local sk = [=[\<\(\u\l\+\)\(\u\l\+\)\+\>]=]
		local sv = [=[\=tolower(substitute(submatch(0), '\(\l\)\(\u\)', '\1_\2', 'g'))]=]
		local tk = [=[\<\(\l\+\)\(_\l\+\)\+\>]=]
		local tv = [=[\U\0]=]
		local fok = [=[\<\(\u\+\)\(_\u\+\)\+\>]=]
		local fov = [=[\=tolower(substitute(submatch(0), '_', '-', 'g'))]=]
		local fik = [=[\<\(\l\+\)\(-\l\+\)\+\>]=]
		local fiv = [=[\=substitute(submatch(0), '-\(\l\)', '\u\1', 'g')]=]
		vim.g["switch_custom_definitions"] = {
			vim.fn["switch#NormalizedCaseWords"]({
				"sunday",
				"monday",
				"tuesday",
				"wednesday",
				"thursday",
				"friday",
				"saturday",
			}),
			vim.fn["switch#NormalizedCase"]({ "yes", "no" }),
			vim.fn["switch#NormalizedCase"]({ "on", "off" }),
			vim.fn["switch#NormalizedCase"]({ "left", "right" }),
			vim.fn["switch#NormalizedCase"]({ "up", "down" }),
			vim.fn["switch#NormalizedCase"]({ "enable", "disable" }),
			{ "==", "!=" },
			{
				[fk] = fv,
				[sk] = sv,
				[tk] = tv,
				[fok] = fov,
				[fik] = fiv,
			},
		}
	end,
}
