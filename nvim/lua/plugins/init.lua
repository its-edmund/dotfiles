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

require('lazy').setup({
    -- ── Core ─────────────────────────────────────────────
    'sbdchd/neoformat', 'junegunn/fzf', 'junegunn/fzf.vim',
    'junegunn/vim-peekaboo', 'octol/vim-cpp-enhanced-highlight',
    'mileszs/ack.vim',
    {'nvim-treesitter/nvim-treesitter', lazy = false, build = ':TSUpdate'}, {
        'nvim-mini/mini.nvim',
        version = false,
        config = function() require("plugins.configs.mini") end
    },
    -- ── Editor ───────────────────────────────────────────
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {"nvim-lua/plenary.nvim"},
        config = function() require("plugins.configs.harpoon") end
    }, {"karb94/neoscroll.nvim", opt = {}}, 'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-tree.lua',
    -- ── Themes ───────────────────────────────────────────
    {'vv9k/bogster', config = function() vim.cmd("colorscheme bogster") end},
    'EdenEast/nightfox.nvim', {"miikanissi/modus-themes.nvim", priority = 1000},
    'rafi/awesome-vim-colorschemes', 'rebelot/kanagawa.nvim',
    {"zenbones-theme/zenbones.nvim", dependencies = "rktjmp/lush.nvim"},
    'vim-scripts/vcbc.vim', 'rodnaph/vim-color-schemes',
    {"nyoom-engineering/oxocarbon.nvim"},
    {"catppuccin/nvim", name = "catppuccin", priority = 1000},
    -- ── Git ───────────────────────────────────────────────
    "tpope/vim-fugitive", {
        "lewis6991/gitsigns.nvim",
        config = function() require("plugins.configs.gitsigns") end
    },
    -- ── LSP ───────────────────────────────────────────────
    {
        "neovim/nvim-lspconfig",
        config = function() require("plugins.configs.linter") end
    }, {
        "mhartington/formatter.nvim",
        config = function() require("plugins.configs.formatter") end
    },
    -- ── Leetcode ──────────────────────────────────────────
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        dependencies = {"nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim"},
        config = function() require("plugins.configs.leetcode") end
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
