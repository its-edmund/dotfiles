local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

lspconfig.clangd.setup({
    cmd = {
        "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clangd",
        "--background-index", "--clang-tidy", "--query-driver=/usr/bin/clang"
    },

    root_dir = function(fname)
        return util.root_pattern("compile_flags.txt", ".clangd",
                                 "compile_commands.json", ".git")(fname) or
                   util.path.dirname(fname)
    end,

    init_options = {
        fallbackFlags = {
            "-I/Users/bytedance/.config/cp", "-std=c++17", "-O2", "-Wall",
            "-Wextra", "-Wshadow", "-Wconversion", "-Wno-sign-conversion"
        }
    }
})
