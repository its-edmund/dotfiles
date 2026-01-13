-- Swap, backup and undo directories
vim.opt.undofile = true
vim.opt.backupdir = vim.fn.expand("~/.config/nvim/backup//")
vim.opt.directory = vim.fn.expand("~/.config/nvim/swap//")
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undo//")

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.timeout = false

-- Line numbers
vim.opt.number = true
vim.opt.signcolumn = 'yes'

-- Mouse mode only enabled in normal mode
vim.opt.mouse = 'n'

-- 
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.updatetime = 250

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.inccommand = 'split'

-- Auto update changes
vim.opt.autoread = true

-- Disable EOL
vim.opt.binary = true
vim.opt.endofline = false
vim.opt.endoffile = false

-- Set tab width
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Prevent newline from comment to continue to comment
vim.opt.formatoptions:remove({"c", "r", "o"})

-- Enable gui colors
vim.opt.termguicolors = true
