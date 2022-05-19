local opt = vim.opt
local globalOptions = vim.g
local cmd = vim.cmd

local default_options = {
  fileencodings = "utf-8",
  encoding = "utf-8",
  hlsearch = true,
  title = true,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  number = true,
  showmatch = true,
  ignorecase = true,
  smartcase = true,
  linebreak = true,
  autoindent = true,
  termguicolors = true,
}

local default_global_options = {
  mapleader = ";",
  background = "dark",
  showcmd = true,
  cmdheight = 1,
  quickrun_config = {
    _ = {
      outputter = "message"
    }
  },
}

for k, v in pairs(default_options) do
  opt[k] = v
end

for k, v in pairs(default_global_options) do
  globalOptions[k] = v
end

-- cmd("runtime colors/NeoSolarized.vim")
cmd("colorscheme aquarium")
