local notify = vim.notify
local api = vim.api
local log = vim.log

local M = {}

function M.map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.t(str)
    return api.nvim_replace_termcodes(str, true, true, true)
end

function M.log(msg, hl, name)
    name = name or "Neovim"
    hl = hl or "Todo"
    api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

function M.warn(msg, name)
    notify(msg, log.levels.WARN, { title = name })
end

function M.error(msg, name)
    notify(msg, log.levels.ERROR, { title = name })
end

function M.info(msg, name)
    notify(msg, log.levels.INFO, { title = name })
end

return M
