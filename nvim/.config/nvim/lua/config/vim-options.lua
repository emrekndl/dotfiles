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
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- netrw tree view
-- vim.g.netrw_liststyle = 3

-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
-- vim.g.netrw_winsize = 25

-- vim.g.netrw_keepdir = 0
-- vim.g.netrw_localcopydircmd = "cp -r"
-- vim.g.netrw_localrmdir = "rm -r"
-- vim.g.netrw_localmkdir = "mkdir -p"
--
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

-- disable virtual text for tiny-inline-diagnostic
vim.diagnostic.config({ virtual_text = false })
