local M = {}

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
function M.set_theme()
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

return M
