local lspconfig = require 'lspconfig'
local lsp = vim.lsp
local split = vim.split
local api = vim.api

lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.eslint.setup {}

require('nvim-autopairs').setup {}

--Enable (broadcasting) snippet capability for completion
local capabilities = lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.jsonls.setup {
  capabilities = capabilities,
}

lspconfig.html.setup {
  capabilities = capabilities,
}

lspconfig.cssls.setup {
  capabilities = capabilities,
}

lspconfig.emmet_ls.setup {
  capabilities = capabilities,
  filetypes = {
    "html",
    "css",
    "typescriptreact",
    "javascriptreact"
  },
}

lspconfig.rust_analyzer.setup {}

local runtime_path = split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup {
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
  },
}
