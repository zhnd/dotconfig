local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local nullls = require("null-ls")

nullls.setup({
  cmd = { "nvim" },
  debounce = 250,
  debug = false,
  default_timeout = 5000,
  diagnostics_format = "#{m}",
  fallback_severity = vim.diagnostic.severity.ERROR,
  log = {
    enable = true,
    level = "warn",
    use_console = "async",
  },
  on_init = nil,
  on_exit = nil,
  update_in_insert = false,
  sources = {
    nullls.builtins.formatting.stylua,
    nullls.builtins.diagnostics.eslint,
    nullls.builtins.completion.spell,
    nullls.builtins.formatting.prettier
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
})
