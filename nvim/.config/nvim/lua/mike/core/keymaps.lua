-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

keymap.set("i", "<C-c>", "<ESC>", { desc = "prime enjoyer" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- center screen w/ down/up
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "GG", "GGzz")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- search-and-replace
keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- too lazy to enter regex for global search command
keymap.set("n", "<leader>r", [[:%s/]])

-- window management
keymap.set("n", "sv", "<C-w>v", { desc = "Split window vertically" })                   -- split window vertically
keymap.set("n", "sh", "<C-w>s", { desc = "Split window horizontally" })                 -- split window horizontally
keymap.set("n", "se", "<C-w>=", { desc = "Make splits equal size" })                    -- make split windows equal width & height


keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("x", "<leader>p", [["_dP]])

keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

-- keymap.set("n", "n", "nzzzv")
-- keymap.set("n", "N", "Nzzzv")

-- get these buffers OUT
keymap.set("n", "<leader>c", "<cmd>bp|bd#<CR>")
-- keymap.set("n", "<leader>x", "<cmd>:bd<CR>", {})              -- close current tab

-- done w/ lyfe
keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

-- Duplicate a line and comment out the first line
-- vim.keymap.set("n", "yc", "yygccp")
