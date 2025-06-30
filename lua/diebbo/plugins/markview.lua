local is_active = vim.g.markview_active or false
local function toggle_markview()
  is_active = not is_active
  vim.g.markview_active = is_active
  if is_active then
    vim.cmd("MarkviewOpen")
  else
    vim.cmd("MarkviewClose")
  end
end

return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    enabled = false,
    config = function()
      vim.g.markview_active = false
      vim.api.nvim_create_user_command("MarkviewToggle", toggle_markview, {})
      vim.keymap.set("n", "<leader>mv", toggle_markview, { desc = "Toggle Markview" })
    end,
  }
}
