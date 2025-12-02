local termfeatures = vim.g.termfeatures or {}
termfeatures.osc52 = false
vim.g.termfeatures = termfeatures

require("julien.core.options")
require("julien.core.keymaps")

vim.defer_fn(function()
    vim.opt.mouse = ""
    vim.cmd([[set mouse=]])
end, 10)
