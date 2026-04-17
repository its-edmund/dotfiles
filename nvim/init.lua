vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.theme")

require("plugins") -- lazy.nvim bootstrap and plugins

-- Diagnostics
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    float = {source = "always"}
})

-- Switch between header and source
function SwitchSourceHeader()
    local file_ext = vim.fn.expand("%:e")
    local file_name_root = vim.fn.expand("%:t:r")

    if file_ext == "cpp" then
        vim.cmd("find " .. file_name_root .. ".h")
    else
        vim.cmd("find " .. file_name_root .. ".cpp")
    end
end
vim.cmd("command! SwitchSourceHeader lua SwitchSourceHeader()")
vim.keymap.set('n', '<Leader>s', ':lua SwitchSourceHeader()<CR>',
               {noremap = true, silent = true})

-- fzf searching
vim.keymap.set('n', '<Leader>f', ':Files<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<Leader>h', ':History<CR>',
               {noremap = true, silent = true})
vim.keymap.set('n', '<Leader>j', ':Buffers<CR>',
               {noremap = true, silent = true})
vim.keymap.set('n', '<Leader>a', ':Ag<Space>', {noremap = true, silent = false})
vim.keymap.set('n', 'gd', ":execute 'Ag ' .. expand('<cword>')<CR>",
               {noremap = true, silent = false})
vim.api.nvim_create_user_command('Ag', function(opts)
    vim.fn['fzf#vim#ag'](opts.args, '-U --color-path="0;33" --literal',
                         opts.bang)
end, {bang = true, nargs = '*'})

-- NvimTree
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
