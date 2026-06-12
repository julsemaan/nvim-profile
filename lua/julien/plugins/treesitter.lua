return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local treesitter = require("nvim-treesitter")

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
        disable = {"c"},
      },
      -- enable indentation
      indent = {
        enable = true,
        disable = { 'yaml' },
      },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "gitignore",
        "query",
        "vimdoc",
        --"c",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })

    -- compat shims for old nvim-treesitter APIs removed in refactor
    -- but still used by some plugins (telescope)
    local parsers = require("nvim-treesitter.parsers")
    if not parsers.ft_to_lang then
      parsers.ft_to_lang = function(ft)
        return vim.treesitter.language.get_lang(ft) or ft
      end
    end

    -- expose our config so telescope's old configs shim can access it
    _G.__ts_highlight_cfg = {
      enable = true,
      disable = { "c" },
    }
    local ts_config = require("nvim-treesitter.config")
    package.loaded["nvim-treesitter.configs"] = {
      setup = function(opts)
        ts_config.setup(opts or {})
      end,
      get_module = function(_, name)
        if name == "highlight" then
          return _G.__ts_highlight_cfg
        end
        return nil
      end,
      is_enabled = function(_, mod, lang, bufnr)
        local m = (mod == "highlight") and _G.__ts_highlight_cfg or nil
        if not m then return false end
        if not vim._ts_has_language(lang) then return false end
        if m.enable == false then return false end
        if type(m.disable) == "table" then
          for _, v in ipairs(m.disable) do
            if lang == v then return false end
          end
        end
        return true
      end,
    }
  end,
}
