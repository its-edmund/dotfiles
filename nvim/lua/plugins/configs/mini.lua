require('mini.basics').setup()
require('mini.comment').setup()
require('mini.statusline').setup()
require('mini.tabline').setup()
require('mini.pairs').setup()
require('mini.starter').setup()
require('mini.move').setup({
    mappings = {
        left = 'H',
        right = 'L',
        down = 'J',
        up = 'K',

        line_left = '<M-h>',
        line_right = '<M-l>',
        line_down = '<M-j>',
        line_up = '<M-k>'
    },

    options = {reindent_linewise = true}
})
require('mini.hipatterns').setup()
require('mini.pick').setup()

vim.keymap.set('n', '<Leader>s', ':Pick grep_live<CR>',
               {noremap = true, silent = true})

vim.keymap.set('n', '<Leader>f', ':Pick files<CR>',
               {noremap = true, silent = true})

-- bufremove
require("mini.bufremove").setup({silent = true})

local function smart_bufdelete()
    local bufremove = require("mini.bufremove")
    local name = vim.fn.bufname(0)
    if name == "" then name = "[No Name]" end

    if vim.bo.modified then
        local choice = vim.fn.confirm(("Save changes to %q?"):format(name),
                                      "&Yes\n&No\n&Cancel", 1)

        if choice == 1 then
            -- If write fails, don't close the buffer.
            local ok = pcall(vim.cmd.write)
            if ok then bufremove.delete(0, false) end
        elseif choice == 2 then
            bufremove.delete(0, true)
        else
            return
        end
    else
        bufremove.delete(0, false)
    end
end

vim.keymap.set("n", "<C-x>", smart_bufdelete, {desc = "Delete Buffer"})
vim.keymap.set("n", "<leader>bD",
               function() require("mini.bufremove").delete(0, true) end,
               {desc = "Delete Buffer (Force)"})
