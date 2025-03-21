-- <space> leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- nerdfont
vim.g.have_nerd_font = true

-- tab space indent 4
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- recursive find
vim.opt.path:append("**")

-- netrw --
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- netrw tree view
vim.g.netrw_liststyle = 3

vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.g.netrw_keepdir = 0
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_localrmdir = "rm -r"
vim.g.netrw_localmkdir = "mkdir -p"

-- swapfile
vim.opt.swapfile = false
vim.opt.backup = false
-- undofile
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- incremental search
vim.opt.incsearch = true

-- line numbers default, relativenumber
vim.opt.number = true
vim.opt.relativenumber = true

-- enable mouse mode
vim.opt.mouse = "a"

-- luarocks
vim.g.rocks_enabled = false

-- don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
-- vim.opt.clipboard = 'unnamedplus'

-- enable break indent
vim.opt.breakindent = true

-- case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- decrease update time
vim.opt.updatetime = 250

-- decrease mapped sequence wait time
-- displays which-key popup sooner
vim.opt.timeoutlen = 300

-- configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- show which line your cursor is on
vim.opt.cursorline = true

-- minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

--
-- Custom Remaps --
--

-- execute the current buffer
vim.keymap.set("n", "<leader>xf", "<cmd>source %<CR>", { desc = "Source the current buffer" })
-- vim.keymap.set("n", "<leader>lx", ":.lua<CR>", { desc = "Run the current line" })
-- vim.keymap.set("v", "<leader>lx", ":lua<CR>", { desc = "Run the visual selected current lines" })

-- highlight move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- File Explore page
vim.keymap.set("n", "<leader>pp", ":Ex<CR>", { desc = "Netrw File Explorer" })
-- vim.keymap.set("n", "<leader>pv", ":Ex<CR>", { desc = "Netrw File Explorer" })
-- vim.keymap.set('n', '<leader>pv', vim.cmd.Rex)
-- Oil File Explore page
-- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>pv", function()
	local oil = require("oil")
	if vim.bo.filetype == "oil" then
		vim.cmd("bdelete")
	else
		oil.open()
	end
end, { desc = "Toggle Oil File Explorer" })

-- J cursor not move
vim.keymap.set("n", "J", "mzJ`z")

-- when half page jumping, cursor in middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- when searching cursor stay in middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- highlight copy and highlight pasting values not save in buffer (multiple highlight pasting firt copying value)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- clipboard register yank
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete void register
vim.keymap.set({ "n", "v" }, "<leader>v", [["_d]])

-- tmux new sessinozer for new project
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/bin/tmux-sessionizer<CR>")

-- quick fix navigating
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

-- substitute shortcut
vim.keymap.set("n", "<leader>g", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- chmod +x file
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true })

-- set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = false
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- tabs page keymaps
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new [T]ab" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close [T]ab" })
-- tab index with LualineBuffersJump! index
vim.keymap.set("n", "gj", function()
	local index = vim.fn.getcharstr()
	local tab_index = tonumber(index)
	if tab_index then
		vim.cmd("LualineBuffersJump! " .. tab_index)
	else
		vim.notify("Invalid index: " .. index, vim.log.levels.ERROR)
	end
end, { desc = "Jump to [T]ab by index" })
-- exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- terminal mod
-- vim.keymap.set("n", "<leader>tt", ":term<CR>", { desc = "Open Terminal" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- keybinds to make split navigation easier.
-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
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

-- disable virtual text for tiny-inline-diagnostic
vim.diagnostic.config({ virtual_text = false })
