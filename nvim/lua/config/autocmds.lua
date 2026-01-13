-- Handle bits/stdc++.h
vim.filetype.add({pattern = {[".*/bits/stdc%+%+%.h"] = "cpp"}})

-- Treesitter config
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function() pcall(vim.treesitter.start) end
})
