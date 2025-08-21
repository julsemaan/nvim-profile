return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local action_state = require('telescope.actions.state')
    local Path = require('plenary.path')
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.providers.telescope")

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    local function open_in_tab_focus(prompt_bufnr)
      local entry = action_state.get_selected_entry()
      if not entry then return end

      -- Get absolute path for reliable comparison
      local filename = Path:new(entry.filename):absolute()
      
      -- Check all tabs and windows for this file
      for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
          local buf = vim.api.nvim_win_get_buf(win)
          local buf_name = Path:new(vim.api.nvim_buf_get_name(buf)):absolute()
          
          if buf_name == filename then
            -- File is already open - focus it
            actions.close(prompt_bufnr)
            vim.api.nvim_set_current_tabpage(tab)
            vim.api.nvim_set_current_win(win)
            return
          end
        end
      end

      -- File not open - open in new tab
      actions.close(prompt_bufnr)
      vim.cmd("tabedit " .. vim.fn.fnameescape(filename))
    end

    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          "venv",
          "node_modules",
          "*.pyc",
          ".git/",
          ".pio/",
          "..ansible/",
        },
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = open_in_tab_focus,
            --["<C-t>"] = trouble_telescope.smart_open_with_trouble,
          },
          n = {
            ["<C-t>"] = open_in_tab_focus,
          },
        },
      },
    })

    -- rely on ripgrep now instead
    --telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<C-p>", "<cmd>Telescope find_files hidden=true no_ignore=false<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<C-b>", "<cmd>Telescope buffers<cr>", { desc = "Telescope buffers" })
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
  end,
}
