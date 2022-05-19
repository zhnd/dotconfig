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

  local function plugins(use)
    use "wbthomason/packer.nvim"
    use "williamboman/nvim-lsp-installer"
    use "neovim/nvim-lspconfig"
    use "hrsh7th/nvim-cmp"
    use {
      "hrsh7th/cmp-nvim-lsp",
      requires = {
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
      },
      config = get_setup("cmp")
    }
    use "saadparwaiz1/cmp_luasnip"
    use { "L3MON4D3/LuaSnip",
      config = function()
        require("luasnip.loaders.from_lua").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load {
        }
        require("luasnip.loaders.from_snipmate").lazy_load()
      end,
    }
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = get_setup("treesitter")
    }
    use {
      "windwp/nvim-autopairs",
      config = get_setup("autopairs")
    }
    use "hoob3rt/lualine.nvim"
    use "folke/lsp-colors.nvim"
    use {
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons",
      },
      config = get_setup("nvim-tree")
    }
    use "nvim-lua/plenary.nvim"
    use {
      "nvim-telescope/telescope.nvim",
      config = get_setup("telescope")
    }
    use {
      "jose-elias-alvarez/null-ls.nvim",
      config = get_setup("null-ls")
    }

    use {
      "akinsho/toggleterm.nvim",
      branch = "main",
      config = get_setup("terminal"),
    }

    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
    }

    use "thinca/vim-quickrun"
    use "frenzyexists/aquarium-vim"
    use {
      "ahmedkhalf/project.nvim",
      config = get_setup("project")
    }

    use {
      'goolord/alpha-nvim',
      config = get_setup('alpha')
    }

    use "github/copilot.vim"

    use {
      "numToStr/Comment.nvim",
      event = "BufRead",
      config = get_setup('comment')
    }

    use {
      "simrat39/rust-tools.nvim",
      config = get_setup('rust-tools')
    }

    use "rizzatti/dash.vim"
    use "vim-test/vim-test"
    use "hrsh7th/cmp-path"

    use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
    })

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
