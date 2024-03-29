vim.g.mapleader = ' '

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "<C-o>", "<C-o>zz")
-- vim.keymap.set("n", "<C-i>", "<C-i>zz")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

-- blackhole paste and delete
vim.keymap.set({ "n", "v" }, "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- system clipboard copy
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")

-- quickfix movings
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set('n', '<S-q>', ':bd<CR>')
vim.keymap.set('n', '<C-q>', ':tabclose<CR>')

-- change split size
vim.keymap.set('n', '<Right>', ':vertical resize +3<CR>')
vim.keymap.set('n', '<Left>', ':vertical resize -3<CR>')
vim.keymap.set('n', '<Up>', ':resize +3<CR>')
vim.keymap.set('n', '<Down>', ':resize -3<CR>')

-- split choosing
vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-j>', '<C-w>j')
vim.keymap.set('n', '<A-k>', '<C-w>k')
vim.keymap.set('n', '<A-l>', '<C-w>l')

vim.keymap.set('n', 'Y', 'y$')

-- allow ">" and "<" retab multiple times (stay in indent mode)
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

vim.cmd [[nnoremap <expr> k (v:count > 2 ? "m'" . v:count : "") . 'k']]
vim.cmd [[nnoremap <expr> j (v:count > 2 ? "m'" . v:count : "") . 'j']]

vim.keymap.set('n', '', ':noh<CR>', { silent = true })
