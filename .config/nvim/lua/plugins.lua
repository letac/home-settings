
local vim = vim
vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

packer.startup(function()
  local use = use
  -- add you plugins here like:
  use 'wbthomason/packer.nvim'

  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp'
  }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', branch = '0.5-compat'}
  use { 'nvim-treesitter/nvim-treesitter-textobjects', branch = '0.5-compat'}
  use 'nvim-treesitter/nvim-treesitter-refactor'

  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  use 'mhinz/vim-startify'

  use { 'nvim-lua/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  use 'EdenEast/nightfox.nvim'
  end
)

require'lualine'.setup()

require('colors')
require('startify')
require('telescope_config')
require('treesitter_config')
require('lsp')
