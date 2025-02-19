vim.g.mapleader = ","


-- Improve space
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap jk to esc
vim.keymap.set({ 'n', 'v', 'i' }, 'jk', '<Esc>')
vim.keymap.set("t", 'jk', "<C-\\><C-n>")

-- Remove highlight
vim.keymap.set('n', '<leader><space>', ':noh<cr>', { desc = 'Remove search highlight' })


-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Navigation slipts
vim.keymap.set({ "n", "t" }, "<c-l>", "<c-w>l", { desc = "Move to left split" })
vim.keymap.set({ "n", "t" }, "<c-k>", "<c-w>k", { desc = "Move to top split" })
vim.keymap.set({ "n", "t" }, "<c-j>", "<c-w>j", { desc = "Move to bottom split" })
vim.keymap.set({ "n", "t" }, "<c-h>", "<c-w>h", { desc = "Move to right split" })

-- Navigation on insert mode
vim.keymap.set("i", "<c-l>", "<Right>", { desc = "Move to right on insert mode" })
vim.keymap.set("i", "<c-h>", "<Left>", { desc = "Move to left on insert mode" })
vim.keymap.set("i", "<c-g>g", "<c-o>E")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


vim.keymap.set("x", "<leader>p", [["_dP]])



-- Yank to system
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])



vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")


vim.keymap.set("n", "Q", "<nop>")

-- Format file using LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Keep center
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace world under
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Open terminal on split
vim.keymap.set("n", "<leader>tn", ":vs term://bash<CR>")
