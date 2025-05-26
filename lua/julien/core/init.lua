local termfeatures = vim.g.termfeatures or {}
termfeatures.osc52 = false
vim.g.termfeatures = termfeatures

require("julien.core.options")
require("julien.core.keymaps")

