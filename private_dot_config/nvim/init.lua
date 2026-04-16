vim.opt.compatible = false

-- I like things to be pretty :)
vim.cmd("syntax on")
vim.opt.termguicolors = true
vim.cmd("colorscheme habamax")

-- Status Bar
local function minimal_statusline()
  return table.concat({
    " %f",        -- filename
    " %m",        -- modified flag
    "%=" ,        -- split left/right
    "%l:%c ",     -- line:col
  })
end

vim.o.laststatus = 0
vim.o.statusline = "%!v:lua.minimal_statusline()"
_G.minimal_statusline = minimal_statusline

-- Tabs should be spaces.
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Quiet down vim!
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Stop automatically inserting comment leaders on new lines
vim.opt.formatoptions:remove({ "c", "r", "o" })

-- Line Numbers. Relative in Normal. Absolute in Insert.
vim.opt.number         = true
vim.opt.relativenumber = true

local group = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
  group = group,
  pattern = "*",
  callback = function()
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = group,
  pattern = "*",
  callback = function()
    vim.opt.relativenumber = true
  end,
})


-- We can have nice things.
vim.opt.incsearch      = true -- Incremental search
vim.opt.inccommand     = "nosplit" -- Shows changes are you type
vim.opt.ignorecase     = true -- Ignore case if all lower-case
vim.opt.smartcase      = true -- Case-sensitive if a letter is uppercase
vim.opt.cursorline     = true -- Highlights current line :)
vim.opt.undofile       = true -- Undo's persist
vim.opt.wrap           = true -- Wraps text
vim.opt.linebreak      = true -- Wraps at word boundary

-- Flash highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})


-- Keybinds
-- Leader key set to space
vim.g.mapleader = " "

-- Better tabbing in visual mode (keep selection after tab)
vim.keymap.set("x", "<", "<gv", { noremap = true })
vim.keymap.set("x", ">", ">gv", { noremap = true })

-- Paste from the yank register only
vim.keymap.set("n", "<leader>p", '"0p', { noremap = true })
vim.keymap.set("n", "<leader>P", '"0P', { noremap = true })

-- Yank visual selection to system clipboard with <leader>y
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, desc = "Yank to clipboard" })
-- In normal mode, <leader>y yanks current line to clipboard
vim.keymap.set("n", "<leader>y", '"+yy', { noremap = true, desc = "Yank line to clipboard" })

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

-- Built-in Plugin Manager
vim.pack.add({
  { src = "https://github.com/unblevable/quick-scope", name = "quick-scope" },
})
-- Only highlight when using f/F
vim.g.qs_highlight_on_keys = { "f", "F" }
vim.g.qs_max_chars = 250  -- Limit width
-- Add underlining
vim.api.nvim_set_hl(0, "QuickScopePrimary",   { underline = true })
vim.api.nvim_set_hl(0, "QuickScopeSecondary", { underline = true })

vim.pack.add({
  { src = "https://github.com/justinmk/vim-sneak", name = "vim-sneak" },
})
-- Enable label mode in vim-sneak
vim.g["sneak#label"] = 1
-- Sneak main match color: maroon background, light text
vim.api.nvim_set_hl(0, "Sneak", {
  fg = "#ffffff",
  bg = "#800020",
  bold = true,
})
vim.api.nvim_set_hl(0, "SneakLabel", {
  fg = "#ffffff",
  bg = "#800020",
  bold = true,
})
vim.api.nvim_set_hl(0, "SneakScope", {
  fg = "#ffffff",
  bg = "#800020",
  bold = true,
})
-- Try to load Sneak and, if successful, unmap our NOP for s
local ok = pcall(vim.cmd.packadd, "vim-sneak")
if ok then
    vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>Sneak_s", { silent = true })
    vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>Sneak_S", { silent = true })
else
    -- Disable 's' key because it's just a worse 'c' by default
    vim.keymap.set({ "n", "v" }, "s", "<nop>")
    vim.keymap.set({ "n", "v" }, "S", "<nop>")
end

