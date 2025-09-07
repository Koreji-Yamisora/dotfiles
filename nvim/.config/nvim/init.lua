-- bootstrap lazy.nvim, LazyVim and your plugins
-- Tell Neovim to use Python from the project venv
vim.g.python3_host_prog = vim.fn.expand("/Users/wenxin/cs/.venv/bin/python")

require("config.lazy")
