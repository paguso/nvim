-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "[W]indow split [V]ertically" }) -- split window vertically
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "[W]indow split [H]orizontally" }) -- split window horizontally
keymap.set("n", "<leader>we", "<C-w>=", { desc = "[W]indow split [E]qual size" }) -- make split windows equal width & height
keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "[W]indow e[X]it (Close)" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "[T]ab [O]pen" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "[T]ab e[X]it (Close)" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "[T]ab [N]ext" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "[T]ab [P]revious" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "[T]ab open with current buffer ([F]ile)" }) --  move current buffer to new tab

-- Resize windows with Ctrl-arrows
vim.cmd([[nnoremap <silent> <C-Left>  :vertical resize -1<CR>]])
vim.cmd([[nnoremap <silent> <C-Right> :vertical resize +1<CR>]])
vim.cmd([[nnoremap  <C-Up>            :resize -1<CR>]])
vim.cmd([[nnoremap  <C-Down>          :resize +1<CR>]])

-- Move around windows
--  See `:help wincmd` for a list of all window commands
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
