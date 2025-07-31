return {
vim.api.nvim_create_autocmd("VimLeave", {
  group = vim.api.nvim_create_augroup("RestoreCursor", { clear = true }),
  pattern = "*",
  callback = function()
    vim.opt.guicursor = "a:ver25"
  end,
  desc = "Restore cursor shape on exit"
})
}
