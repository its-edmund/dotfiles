vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Buffer management
vim.keymap.set('n', '<Leader>x', ':bd<CR>')
vim.keymap.set('n', '<Tab>', ':bnext<CR>')
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>')
vim.keymap.set('n', '<Leader>x', ':bd<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', { noremap = true, silent = true })

-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Switch between header and source
vim.api.nvim_set_keymap('n', '<Leader>s', ':lua SwitchSourceHeader()<CR>', { noremap = true, silent = true })

-- fzf searching
vim.api.nvim_set_keymap('n', '<Leader>f', ':Files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>h', ':History<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>j', ':Buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>a', ':Ag<Space>', { noremap = true, silent = false })

-- System clipboard shortcut
vim.keymap.set('n', '<Leader>y', '"+y', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>p', '"+p', { noremap = true, silent = true })

require('lazy').setup({
		'airblade/vim-gitgutter',
		'junegunn/fzf',
		'junegunn/fzf.vim',
		'junegunn/vim-peekaboo',
		'octol/vim-cpp-enhanced-highlight',
		'nvim-tree/nvim-tree.lua',
		'tpope/vim-fugitive',
		'mileszs/ack.vim',
		{ "miikanissi/modus-themes.nvim", priority = 1000 },
		'rafi/awesome-vim-colorschemes',
		'rebelot/kanagawa.nvim',
		{
			"zenbones-theme/zenbones.nvim",
			dependencies = "rktjmp/lush.nvim"
		},
		'vim-scripts/vcbc.vim',
		'rodnaph/vim-color-schemes'
})

vim.opt.termguicolors = true

-- Function to detect macOS system theme
local function detect_system_theme()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local result = handle:read("*a")
  handle:close()

  if result:find("Dark") then
    return "dark"
  else
    return "light"
  end
end

-- Function to set Neovim theme based on system theme
local function set_theme()
  local theme = detect_system_theme()

  if theme == "dark" then
    vim.opt.background = "dark"
    vim.cmd("colorscheme default")  -- Replace with your preferred dark theme
  else
    vim.opt.background = "light"
    vim.cmd("colorscheme white")  -- Replace with your preferred light theme
  end
end

-- Apply the theme
set_theme()

function SwitchSourceHeader()
  local file_ext = vim.fn.expand("%:e")
  local file_name_root = vim.fn.expand("%:t:r")
  
  if file_ext == "cpp" then
    vim.cmd("find " .. file_name_root .. ".h")
  else
    vim.cmd("find " .. file_name_root .. ".cpp")
  end
end

-- Set up a command to call the function
vim.cmd("command! SwitchSourceHeader lua SwitchSourceHeader()")

-- NvimTree setup
require("nvim-tree").setup()
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-p>', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

-- ack.vim
vim.g.ackpreview = 1

if vim.fn.executable('ag') == 1 then
  vim.g.ackprg = 'ag --vimgrep --all-text --depth -1'
end
