vim.g.startify_session_dir = "~/.config/nvim/session"
vim.g.startify_lists = {
    {
        type = "files",
        header = { "   Files" },
    },
    {
        type = "dir",
        header = { "   Files " .. vim.fn.getcwd() },
    },
    {
        type = "sessions",
        header = { "   Sessions" },
    },
    {
        type = "bookmarks",
        header = { "   Bookmarks" },
    },
    {
        type = "commands",
        header = { "   Commands" },
    },
}
vim.g.startify_bookmarks = {
    {
        i = "~/.config/nvim/init.lua",
    },
    {
        p = "~/.config/nvim/lua/plugins.lua",
    },
    {
        b = "~/.config/bspwm/bspwmrc",
    },
    {
        s = "~/.config/sxhkd/sxhkdrc",
    },
}
