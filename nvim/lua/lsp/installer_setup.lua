local lsp_installer = require "nvim-lsp-installer"

-- Include the servers you want to have installed by default below
local servers = {
  "cssls",
  "dotls",
  "eslint",
  "emmet_ls",
  "graphql",
  "jsonls",
  "quick_lint_js",
  "tsserver",
  "sumneko_lua",
  "zeta_note",
  "prismals",
  "pyright",
  "rust_analyzer",
  "taplo",
  "tailwindcss",
  "yamlls",
}

lsp_installer.settings({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end
