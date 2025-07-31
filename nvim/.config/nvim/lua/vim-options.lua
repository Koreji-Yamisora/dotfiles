vim.g.mapleader = " "
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.backspace = { "start", "eol", "indent" }

vim.keymap.set("i", "jk", "<Esc>l")
vim.keymap.set("n", "<CR>", ':call append(line("."), "")<CR>j==', { noremap = true, silent = true })
vim.keymap.set("n", "<S-CR>", ':call append(line(".") - 1, "")<CR>k==', { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", ":nohl<CR>")
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', {})

-- Show diagnostic in floating window
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- Show all diagnostics in quickfix
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })

vim.cmd([[
  highlight! LineNr guibg=NONE
  highlight! CursorLineNr guibg=NONE
  highlight! SignColumn guibg=NONE
]])

vim.diagnostic.config({
	virtual_text = {
		enabled = true,
		source = "if_many", -- Show source (eslint, typescript, etc.)
		spacing = 4, -- Space between code and virtual text
		severity = { min = vim.diagnostic.severity.HINT }, -- Show all levels
	},
	signs = true,
	underline = true,
	float = {
		border = "rounded",
		source = "always",
	},
})
