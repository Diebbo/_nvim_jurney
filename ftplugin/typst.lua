local typst_win = nil
local typst_buf = nil

local function show_typst_output()
  if not typst_buf or not vim.api.nvim_buf_is_valid(typst_buf) then
    vim.notify('no typst terminal running', vim.log.levels.WARN)
    return
  end
  if typst_win and vim.api.nvim_win_is_valid(typst_win) then
    vim.api.nvim_set_current_win(typst_win)
    return
  end
  local width = math.min(120, vim.o.columns - 8)
  local height = math.min(30, vim.o.lines - 8)
  typst_win = vim.api.nvim_open_win(typst_buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    border = 'rounded',
    title = ' typst watch ',
    title_pos = 'center',
  })
end

local function hide_typst_output()
  if typst_win and vim.api.nvim_win_is_valid(typst_win) then
    vim.api.nvim_win_hide(typst_win)
  end
end

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*.typ',
  callback = function()
    if typst_buf and vim.api.nvim_buf_is_valid(typst_buf) then
      return
    end

    local file = vim.fn.expand '%:p'

    typst_buf = vim.api.nvim_create_buf(true, true)
    vim.bo[typst_buf].bufhidden = 'hide'

    local width = math.min(120, vim.o.columns - 8)
    local height = math.min(30, vim.o.lines - 8)

    typst_win = vim.api.nvim_open_win(typst_buf, true, {
      relative = 'editor',
      width = width,
      height = height,
      row = math.floor((vim.o.lines - height) / 2),
      col = math.floor((vim.o.columns - width) / 2),
      border = 'rounded',
      title = ' typst watch ',
      title_pos = 'center',
    })

    vim.fn.termopen { 'typst', 'watch', file }
    vim.api.nvim_win_hide(typst_win)

    local pdf = vim.fn.expand '%:p:r' .. '.pdf'
    vim.keymap.set('n', '<leader>tp', function()
      vim.fn.jobstart { 'sioyek', pdf }
    end, { desc = 'open sioyek' }, { buffer = true })

    vim.keymap.set('n', '<leader>ts', show_typst_output, { desc = 'toggle ouput of typst wathc' }, { buffer = true })
  end,
})
