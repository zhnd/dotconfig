local map = require("utils").map

map("n", "<leader>e", ":NvimTreeToggle<CR>")
map("n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>")
