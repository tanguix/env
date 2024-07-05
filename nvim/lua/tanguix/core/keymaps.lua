

-- @@@@@@@@@@@@@@@@@@@@ keybinding pattern @@@@@@@@@@@@@@@@@@@@@
-- vim.api.nvim_set_keymap( {mode}, {keymap{, {mapped_to}, {options} )
-- 1. Global Options (vim.opt)
-- 2. Local to Window (vim.wo)
-- 3. Local to buffer (vim.bo)
-- 4. Reload configuration (:so ~/.config/nvim/init.lua | :so %)
-- 5. <CR> means "enter" key

-- < set {options} placeholder >
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- < set shorten function name for vim.api.nvim_set_keymap, so don't need to type each time mapping keys >
local keymap = vim.api.nvim_set_keymap
--------------------------------------------------------------------------------------------------------------------

-- @@@@@@@@@@@@@@@@@@@@ Leader Key @@@@@@@@@@@@@@@@@@@@@ --
-- : remap to <space>
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "



-- @@@@@@@@@@@@@@@@@@@@ General Keymaps @@@@@@@@@@@@@@@@@@@@@ --
-- Normal Mode:
keymap("n", "<C-s>", ":w<CR>", opts) -- for other terminals that can't map cmd + s as autosave
keymap("n", "nh", ":nohl<CR>", opts) -- cancel search/match highlighting, type "nh" in normal mode
keymap("n", "x", '"_x', opts) -- cancel x for copy, only used for delete
keymap("n", "<C-c>", ": %y+<CR>", opts) -- copy the entire file to the system clipboard
-- Buffer & Tabs (Normal Mode)
keymap("n", "<leader>t", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap("n", "<leader>w", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close current buffer" }) -- close current buffer
keymap("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
keymap("n", "<S-h>", "<cmd>bprev<CR>", { desc = "Go to previous buffer" })
keymap("n", "<Tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap("n", "<S-Tab>", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
--keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window



-- Insert Mode, "jk" exit, because normal no words have jk linked together
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap("i", "<C-b>", "<ESC>^i", opts) -- Move to the beginning of the line in Insert Mode
keymap("i", "<C-e>", "<End>", opts) -- Move to the end of the line in Insert Mode



-- Visual Mode --
-- indentation in visual model: press > for right indent, < for left indent --
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)



-- @@@@@@@@@@@@@@@@@@@@ Other Keymaps @@@@@@@@@@@@@@@@@@@@@ --
-- for plugins specific navigation, you can defined in their own .lua file, lazy load them
-- so only when you use those plugins will they be activated
-- keymap("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
