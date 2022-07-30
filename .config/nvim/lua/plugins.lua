local vim = vim
vim.cmd("packadd packer.nvim")
require("packer").startup(function(use)
    -- add you plugins here like:
    use("wbthomason/packer.nvim")

    use("EdenEast/nightfox.nvim")

    -- nvim-cmp
    use("hrsh7th/nvim-cmp")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lua")

    -- nvim-lspconfig
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")
    use("ray-x/lsp_signature.nvim")
    use("simrat39/rust-tools.nvim")

    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("nvim-treesitter/nvim-treesitter-refactor")
    use("p00f/nvim-ts-rainbow")
    use("romgrk/nvim-treesitter-context")
    use("folke/twilight.nvim")

    use({ "kyazdani42/nvim-web-devicons" })
    use({
        "nvim-lualine/lualine.nvim",
        requires = {
            { "kyazdani42/nvim-web-devicons" },
        },
    })

    use("mhinz/vim-startify")

    use({
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })
end)

vim.cmd([[colorscheme nightfox]])
require("config.lsp")
require("config.null_ls")
require("config.treesitter")
require("treesitter-context").setup({ enable = true })
require("twilight").setup({})
require("lualine").setup({})
require("config.startify")
require("config.telescope")

vim.cmd([[autocmd BufEnter * :TwilightEnable]])
