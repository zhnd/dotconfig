local fn = vim.fn
local cmd = vim.cmd

local function get_setup(name)
  return string.format('require("plugin.config.%s")', name)
end

local M = {}

function M.setup()
  local packer_bootstrap = false

  local function packer_init()
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      cmd [[packadd packer.nvim]]
    end
    cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use 'wbthomason/packer.nvim'
    use 'williamboman/nvim-lsp-installer'
    use "neovim/nvim-lspconfig"
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use {
      'hrsh7th/cmp-nvim-lsp',
      config = get_setup('cmp')
    } -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = get_setup('treesitter')
    }
    use 'windwp/nvim-autopairs'
    use 'hoob3rt/lualine.nvim'
    use 'folke/lsp-colors.nvim'
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons',
      },
      config = get_setup('nvim-tree')
    }
    use "nvim-lua/plenary.nvim"
    use {
      'nvim-telescope/telescope.nvim',
    }
    use {
      "jose-elias-alvarez/null-ls.nvim",
      config = get_setup('null-ls')
    }


    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()
  local packer = require "packer"
  packer.init()
  packer.startup(plugins)
end

return M
