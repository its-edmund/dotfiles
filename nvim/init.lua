vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo,
        lazypath
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            {"Failed to clone lazy.nvim:\n", "ErrorMsg"}, {out, "WarningMsg"},
            {"\nPress any key to exit..."}
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

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

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
               {desc = 'Open diagnostic [Q]uickfix list'})

-- Buffer management
vim.keymap.set('n', '<Tab>', ':bnext<CR>')
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>')
vim.keymap.set('n', '<Tab>', ':bnext<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', {noremap = true, silent = true})

-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>',
               {desc = 'Move focus to the left window'})
vim.keymap.set('n', '<C-l>', '<C-w><C-l>',
               {desc = 'Move focus to the right window'})
vim.keymap.set('n', '<C-j>', '<C-w><C-j>',
               {desc = 'Move focus to the lower window'})
vim.keymap.set('n', '<C-k>', '<C-w><C-k>',
               {desc = 'Move focus to the upper window'})

vim.keymap.set('n', '<C-c>', ':%yank +<CR>', {noremap = true, silent = true})

-- Switch between header and source
vim.keymap.set('n', '<Leader>s', ':lua SwitchSourceHeader()<CR>',
               {noremap = true, silent = true})

-- fzf searching
vim.keymap.set('n', '<Leader>f', ':Pick files<CR>',
               {noremap = true, silent = true})
-- vim.keymap.set('n', '<Leader>f', ':Files<CR>', {noremap = true, silent = true})
-- vim.keymap
--     .set('n', '<Leader>h', ':History<CR>', {noremap = true, silent = true})
-- vim.keymap
--     .set('n', '<Leader>j', ':Buffers<CR>', {noremap = true, silent = true})
-- vim.keymap.set('n', '<Leader>a', ':Ag<Space>', {noremap = true, silent = false})
-- vim.keymap.set('n', 'gd', ":execute 'Ag ' .. expand('<cword>')<CR>",
--                {noremap = true, silent = false})
-- vim.api.nvim_create_user_command('Ag', function(opts)
--     vim.fn['fzf#vim#ag'](opts.args, '-U --color-path="0;33" --literal',
--                          opts.bang)
-- end, {bang = true, nargs = '*'})

-- System clipboard shortcut
vim.keymap.set('n', '<Leader>y', '"+y', {noremap = true, silent = true})
vim.keymap.set('n', '<Leader>p', '"+p', {noremap = true, silent = true})

-- Handle bits/stdc++.h
vim.filetype.add({pattern = {[".*/bits/stdc%+%+%.h"] = "cpp"}})

require('lazy').setup({
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
        dependencies = {
            -- include a picker of your choice, see picker section for more details
            "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim"
        },
        opts = {
            injector = {
                ["cpp"] = {
                    imports = function()
                        return {
                            "#include <bits/stdc++.h>", "using namespace std;"
                        }
                    end,
                    after = "int main() {}"
                }
            },
            image_support = false
        }
    }, 'MunifTanjim/nui.nvim', 'vv9k/bogster', 'EdenEast/nightfox.nvim',
    'sbdchd/neoformat', 'junegunn/fzf', 'junegunn/fzf.vim',
    'junegunn/vim-peekaboo', 'octol/vim-cpp-enhanced-highlight',
    'nvim-tree/nvim-tree.lua', 'mileszs/ack.vim',
    {"miikanissi/modus-themes.nvim", priority = 1000},
    'rafi/awesome-vim-colorschemes', 'rebelot/kanagawa.nvim',
    {"zenbones-theme/zenbones.nvim", dependencies = "rktjmp/lush.nvim"},
    'vim-scripts/vcbc.vim', 'rodnaph/vim-color-schemes',
    {'nvim-treesitter/nvim-treesitter', lazy = false, build = ':TSUpdate'},
    {'nvim-mini/mini.nvim', version = false}, {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {"nvim-lua/plenary.nvim"}
    }, {"karb94/neoscroll.nvim", opt = {}}, {
        "nyoom-engineering/oxocarbon.nvim"
        -- Add in any other configuration; 
        --   event = foo, 
        --   config = bar
        --   end,
    }, {"catppuccin/nvim", name = "catppuccin", priority = 1000},
    "tpope/vim-fugitive", "lewis6991/gitsigns.nvim",
    {"neovim/nvim-lspconfig", config = function() require("plugins.linter") end},
    {
        "mhartington/formatter.nvim",
        config = function() require("plugins.formatter") end
    }, {
        "echasnovski/mini.bufremove",

        keys = {
            {
                "<C-x>",
                function()
                    local bd = require("mini.bufremove").delete
                    if vim.bo.modified then
                        local choice = vim.fn.confirm(
                                           ("Save changes to %q?"):format(vim.fn
                                                                              .bufname()),
                                           "&Yes\n&No\n&Cancel")
                        if choice == 1 then -- Yes
                            vim.cmd.write()
                            bd(0)
                        elseif choice == 2 then -- No
                            bd(0, true)
                        end
                    else
                        bd(0)
                    end
                end,
                desc = "Delete Buffer"
            }, -- stylua: ignore
            {
                "<leader>bD",
                function()
                    require("mini.bufremove").delete(0, true)
                end,
                desc = "Delete Buffer (Force)"
            }
        }
    }, {
        "3rd/image.nvim",
        build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
        opts = {
            processor = "magick_cli",
            editor_only_render_when_focused = true,
            window_overlap_clear_enabled = true, -- auto show/hide images when the editor gains/looses focus
            tmux_show_only_in_active_window = true
        }
    }
})

vim.opt.termguicolors = true

-- Treesitter config
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'<filetype>'},
    callback = function() vim.treesitter.start() end
})

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

    vim.cmd("colorscheme bogster")

    -- if theme == "dark" then
    --     vim.opt.background = "dark"
    --     vim.cmd("colorscheme catppuccin-mocha") -- Replace with your preferred dark theme
    -- else
    --     vim.opt.background = "light"
    --     vim.cmd("colorscheme white") -- Replace with your preferred light theme
    -- end
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
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>p', ':NvimTreeFindFile<CR>',
                        {noremap = true, silent = true})

-- ack.vim
vim.g.ackpreview = 1

if vim.fn.executable('ag') == 1 then
    vim.g.ackprg = 'ag -U --vimgrep --all-text --depth -1'
end

-- Formatting configuration
vim.g.neoformat_basic_format_align = 1
vim.g.neoformat_basic_format_retab = 1
vim.g.neoformat_basic_format_trim = 1
-- Trigger neoformat on <leader>=
vim.keymap.set('n', '<leader>=', ':Neoformat<CR>')
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*", -- You can specify filetypes here, e.g., "*.js"
    callback = function() vim.cmd("Neoformat") end
})

-- Mini.nvim configuration
require('mini.basics').setup()
require('mini.comment').setup()
require('mini.statusline').setup()
require('mini.tabline').setup()
require('mini.pairs').setup()
require('mini.starter').setup()
require('mini.move').setup({
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = 'H',
        right = 'L',
        down = 'J',
        up = 'K',

        -- Move current line in Normal mode
        line_left = '<M-h>',
        line_right = '<M-l>',
        line_down = '<M-j>',
        line_up = '<M-k>'
    },

    -- Options which control moving behavior
    options = {
        -- Automatically reindent selection during linewise vertical move
        reindent_linewise = true
    }
})
require('mini.hipatterns').setup()
require('mini.pick').setup()

-- Harpoon configuration
local harpoon = require('harpoon')
harpoon:setup()

vim.keymap.set("n", "<leader>e", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>",
               function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

-- Gitsigns
require('gitsigns').setup()
