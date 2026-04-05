
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.errorbells = false
vim.opt.visualbell = false


vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.cursorline     = true


vim.opt.incsearch      = true
vim.opt.undofile       = true
vim.opt.wrap           = true
vim.opt.linebreak      = true
vim.opt.ignorecase     = true
vim.opt.smartcase      = true


-- Keybinds
-- Better tabbing in visual mode (keep selection after tab)
vim.keymap.set("x", "<", "<gv", { noremap = true })
vim.keymap.set("x", ">", ">gv", { noremap = true })
-- Paste from the yank register only
vim.keymap.set("n", "<leader>p", '"0p', { noremap = true })
vim.keymap.set("n", "<leader>P", '"0P', { noremap = true })
-- Move current line (or count of lines) up/down in normal mode
vim.keymap.set("n", "<C-j>",
  [[:<C-u>execute ':.,.' . v:count . 'm+' . v:count1 <bar> normal! ==<CR>]],
  { noremap = true, expr = false, silent = true }
)
vim.keymap.set("n", "<C-k>",
  [[:<C-u>execute ':.,.' . v:count . 'm-2' <bar> normal! ==<CR>]],
  { noremap = true, expr = false, silent = true }
)
-- Move selected block up/down and reselect
vim.keymap.set("v", "<C-j>", [[:m '>+1<CR>gv=gv]], { noremap = true, silent = true })
vim.keymap.set("v", "<C-k>", [[:m '<-2<CR>gv=gv]], { noremap = true, silent = true })
