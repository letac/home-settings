local vim = vim
vim.cmd("packadd packer.nvim")
local packer = require("packer")
local util = require("packer.util")
packer.init({
    package_root = util.join_paths(vim.fn.stdpath("data"), "site", "pack"),
})

packer.startup(function(use)
    -- add you plugins here like:
    use("wbthomason/packer.nvim")

    use({
        "EdenEast/nightfox.nvim",
        config = vim.cmd([[colorscheme nightfox]]),
    })

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
        config = require("lsp"),
    })

    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = require("null_ls_config"),
    })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = require("treesitter_config"),
    })
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("nvim-treesitter/nvim-treesitter-refactor")

    use({ "kyazdani42/nvim-web-devicons" })
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = require("lualine").setup(),
    })

    use({
        "mhinz/vim-startify",
        config = require("startify"),
    })

    use({
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = require("telescope_config"),
    })
end)
