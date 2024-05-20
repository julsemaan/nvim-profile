return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    local lsp_ensure_installed = {
      "gopls",
    }
    if vim.fn.executable('npm') == 1 then
      table.insert(lsp_ensure_installed, "bashls")
      table.insert(lsp_ensure_installed, "html")
      table.insert(lsp_ensure_installed, "cssls")
    end

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = lsp_ensure_installed,
      --ensure_installed = {
      --  "gopls",
      --  "bashls",
      --  --"tsserver",
      --  --"html",
      --  --"cssls",
      --  --"tailwindcss",
      --  --"svelte",
      --  --"lua_ls",
      --  --"graphql",
      --  --"emmet_ls",
      --  --"prismals",
      --  --"pyright",
      --},
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "gopls",
        --"prettier", -- prettier formatter
        --"stylua", -- lua formatter
        --"isort", -- python formatter
        --"black", -- python formatter
        --"pylint",
        --"eslint_d",
      },
    })
  end,
}
