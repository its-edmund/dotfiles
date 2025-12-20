-- lua/plugins/formatter.lua
local formatter = require("formatter")
local util = require "formatter.util"

-- Configure formatter
formatter.setup({
    logging = true,
    log_level = vim.log.levels.DEBUG,
    filetype = {
        lua = {
            -- lua-format
            function()
                return {exe = "lua-format", args = {}, stdin = true}
            end
        },
        typescriptreact = {
            -- Use eslint_d for TSX files
            function()
                return {
                    exe = "eslint_d",
                    args = {
                        "--stdin", "--stdin-filename",
                        util.escape_path(util.get_current_buffer_file_path()),
                        "--fix-to-stdout"
                    },
                    stdin = true,
                    try_node_modules = true
                }
            end
        },
        cpp = {
            function()
                return {
                    exe = "clang-format",
                    args = {
                        "-style=\"{IndentWidth: 8, UseTab: Always, TabWidth: 8}\"",
                        "--assume-filename",
                        util.escape_path(util.get_current_buffer_file_name())
                    },
                    stdin = true,
                    try_node_modules = true
                }
            end
        }
    }
})

-- Optional: Define a command to run formatting easily
vim.api.nvim_exec([[
augroup FormatAutogroup
autocmd!
autocmd BufWritePost *.lua,*.tsx FormatWrite
augroup END
]], true)
