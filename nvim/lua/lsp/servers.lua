local split = vim.split
local api = vim.api

local runtime_path = split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Include the servers you want to have installed by default below
local servers = {
  { "emmet_ls",
    filetypes = {
      "html",
      "css",
      "typescriptreact",
      "javascriptreact"
    }
  },
  { "cssls" },
  { "cssmodules_ls" },
  { "dotls" },
  { "jsonls" },
  { "tsserver" },
  { "sumneko_lua",
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    }, },
  { "prismals" },
  { "pyright" },
  { "rust_analyzer" },
  { "taplo" },
  { "yamlls" },
  { "solc" },
}

return servers
