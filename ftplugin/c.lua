vim.keymap.set("n", "<leader>K", function()
  vim.cmd("Man 3 " .. vim.fn.expand("<cword>"))
end, { buffer = true, desc = "Man 3 lookup" })
