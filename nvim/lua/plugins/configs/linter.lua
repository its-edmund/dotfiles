vim.lsp.config('clangd', {
    cmd = {
        "clangd",
        "--background-index", "--clang-tidy", "--query-driver=/usr/bin/clang"
    },

    filetypes = {"c", "cpp", "objc", "objcpp", "cuda"},

    init_options = {
        fallbackFlags = {
            "-std=c++17", "-O2", "-Wall", "-Wextra", "-Wshadow", "-Wconversion",
            "-Wno-sign-conversion"
        }
    }
})

vim.lsp.enable('clangd')
