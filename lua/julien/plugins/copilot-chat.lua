return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    config = function()
      local copilot_chat = require("CopilotChat")

      copilot_chat.setup()

      -- set keymaps
      local keymap = vim.keymap -- for conciseness

      keymap.set("n", "<leader>cps", "<cmd>Copilot<cr>", { desc = "Ask Copilot for suggestions" })
      keymap.set("n", "<leader>cpc", "<cmd>CopilotChat<cr>", { desc = "Open Copilot chat" })
      keymap.set("n", "<leader>cpm", "<cmd>CopilotChatModels<cr>", { desc = "Choose Copilot chat model" })

      vim.opt.completeopt = {'menuone', 'noinsert', 'noselect', 'popup'}

      vim.api.nvim_set_keymap('i', '<C-CR>', 'copilot#Accept("<Tab>")', { silent = true, expr = true })

    end,
    -- See Commands section for default commands if you want to lazy load on them
  },
}
