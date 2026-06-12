return {
  "folke/snacks.nvim",
  opts = {
    scope = {
      filter = function(buf)
        return vim.bo[buf].buftype == ""
          and vim.b[buf].snacks_scope ~= false
          and vim.g.snacks_scope ~= false
          and vim.bo[buf].filetype ~= "markdown"
      end,
    },
  },
}
