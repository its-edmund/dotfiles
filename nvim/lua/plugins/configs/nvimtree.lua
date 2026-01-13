require("nvim-tree").setup()

vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<CR>",
               {silent = true, desc = "NvimTree Toggle"})
vim.keymap.set("n", "<leader>p", "<cmd>NvimTreeFindFile<CR>",
               {silent = true, desc = "NvimTree Find File"})
