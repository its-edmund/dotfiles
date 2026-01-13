require("leetcode").setup({
    injector = {
        ["cpp"] = {
            imports = function()
                return {"#include <bits/stdc++.h>", "using namespace std;"}
            end
        }
    },
    image_support = false
})
