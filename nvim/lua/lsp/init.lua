local M = {}

function M.setup()
  require("lsp.installer").setup()
  require("lsp.config")
end

return M
