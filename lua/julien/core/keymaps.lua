vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })                   -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })                 -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })                    -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })               -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", ",l", "<cmd>tabn<CR>", { desc = "Go to next tab" })                             --  go to next tab
keymap.set("n", ",k", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                         --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Toggle line numbers
keymap.set("n", "<leader>lne", "<cmd>:set number <CR> <BAR> :set relativenumber <CR> <BAR> :IBLEnable <CR> <BAR> :set scl=yes <CR>", { desc = "Enable line numbers and indentation markers" })
keymap.set("n", "<leader>lnd", "<cmd>:set nonumber <CR> <BAR> :set norelativenumber <CR> <BAR> :IBLDisable <CR> <BAR> :set scl=no <CR>", { desc = "Disable line numbers and indentation markers" })

-- Print current file path
keymap.set("n", "<leader>pf", "<cmd>:!echo %<CR>", { desc = "Print the current filename"})

keymap.set("n", "<leader>cbe", "<cmd>:set clipboard=unnamedplus <CR>", { desc = "Enable using the OS clipboard" })
keymap.set("n", "<leader>cbd", "<cmd>:set clipboard= <CR>", { desc = "Disable using the OS clipboard" })
