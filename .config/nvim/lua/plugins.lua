local vim = vim
vim.cmd("packadd packer.nvim")
local packer = require("packer")
local util = require("packer.util")
packer.init({
    package_root = util.join_paths(vim.fn.stdpath("data"), "site", "pack"),
})

packer.startup(function()
    local use = use
    -- add you plugins here like:
    use("wbthomason/packer.nvim")

    use({
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lua",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    })

    use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } })

    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("nvim-treesitter/nvim-treesitter-refactor")

    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    use("mhinz/vim-startify")

    use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })

    use("EdenEast/nightfox.nvim")
end)

require("lualine").setup()
require("colors")

require("null_ls_config")
require("startify")
require("telescope_config")
require("treesitter_config")
require("lsp")
