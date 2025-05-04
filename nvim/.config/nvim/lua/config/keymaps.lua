--
-- Custom Remaps --
--

-- execute the current buffer
-- vim.keymap.set("n", "<leader>xf", "<cmd>source %<CR>", { desc = "Source the current buffer" })
-- vim.keymap.set("n", "<leader>lx", ":.lua<CR>", { desc = "Run the current line" })
-- vim.keymap.set("v", "<leader>lx", ":lua<CR>", { desc = "Run the visual selected current lines" })

-- highlight move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- File Explore page
-- vim.keymap.set("n", "<leader>pv", ":Ex<CR>", { desc = "Netrw File Explorer" })
-- vim.keymap.set('n', '<leader>pv', vim.cmd.Rex)
-- Oil File Explore page
-- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>-", function()
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

-- visual select move
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

-- highlight copy and highlight pasting values not save in buffer (multiple highlights pasting first copying value)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- clipboard register yank
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })

-- delete void register
vim.keymap.set({ "n", "v" }, "<leader>v", [["_d]], { desc = "Delete void resgister" })

-- tmux new sessinozer for new project
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/bin/tmux-sessionizer<CR>")

-- quick fix navigating
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

-- substitute shortcut
vim.keymap.set("n", "<leader>ra", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "substitute" })

-- chmod +x file
vim.keymap.set("n", "<leader>mx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "chmod +x" })

-- set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = false
-- vim.keymap.set("n", "", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- tabs page keymaps
-- vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new [T]ab" })
-- vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close [T]ab" })
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
--
--
-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree" })

-- copy file path with ~ (home directory)
vim.keymap.set("n", "<leader>mp", function()
	local path = vim.fn.expand("%:~")
	vim.fn.setreg("+", path)
	vim.notify("File path copied to clipboard: " .. path, vim.log.levels.INFO)
end, { desc = "Copy file path" })
