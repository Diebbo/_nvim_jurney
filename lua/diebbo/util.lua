local M = {}

--- patch_hl adds highlight definition without replacing original highlight
--- useful when we need to override highlight and retain existing definition
---
--- @param hlg string Highlight group name
--- @param patch table Override highlight
function M.patch_hl(hlg, patch)
  local hl = vim.api.nvim_get_hl(0, {
    name = hlg,
  })
  vim.api.nvim_set_hl(0, hlg, vim.tbl_deep_extend('keep', patch, hl))
end

function M.patch_group_pattern(hlg_pattern, patch)
  for _, hlg in pairs(vim.fn.getcompletion(hlg_pattern, 'highlight')) do
    M.patch_hl(hlg, patch)
  end
end

---@param s string
---@param opts? {should_truncate: boolean?, maxlen: integer?}
function M.truncate_string(s, opts)
  opts = vim.tbl_extend('force', {
    should_truncate = true,
    maxlen = 0,
  }, opts or {})
  if opts.should_truncate and opts.maxlen == 0 then
    return ''
  end
  if opts.should_truncate and vim.api.nvim_strwidth(s) >= opts.maxlen then
    local trimmed = string.sub(s, 1, opts.maxlen)
    local pattern = '[-_]$'
    s = string.gsub(trimmed, pattern, '') .. '..'
  end
  return s
end

-- Utility function to create a floating window
function M.create_floating_window(params)
  -- Default parameters
  local defaults = {
    width = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.8),
    row = nil,
    col = nil,
    buf = nil,
    enter = true,
  }

  -- Merge provided parameters with defaults
  params = vim.tbl_extend('force', defaults, params or {})

  -- Calculate row and column if not provided
  params.row = params.row or math.floor((vim.o.lines - params.height) / 2)
  params.col = params.col or math.floor((vim.o.columns - params.width) / 2)

  -- Create buffer if not provided
  local buf = params.buf or vim.api.nvim_create_buf(false, true)

  -- Define window options
  local opts = {
    relative = 'editor',
    width = params.width,
    height = params.height,
    row = params.row,
    col = params.col,
    style = 'minimal',
    border = 'rounded',
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, params.enter, opts)

  return {
    buf = buf,
    win = win,
    opts = opts,
  }
end

-- Generic floating window/terminal manager
function M.create_toggleable_float(float_type)
  -- State tracking
  local state = {
    buf = nil,
    win = nil,
    type = float_type,
  }

  return function()
    -- Create or reuse buffer
    if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
      state.buf = vim.api.nvim_create_buf(false, true)
    end

    -- Check window validity
    local win_valid = state.win and vim.api.nvim_win_is_valid(state.win)

    if not win_valid then
      -- Create new floating window
      local float = M.create_floating_window { buf = state.buf }
      state.win = float.win

      -- Special handling for terminal
      if float_type == 'terminal' then
        if vim.bo[state.buf].buftype ~= 'terminal' then
          vim.cmd.terminal()
          vim.cmd.startinsert()
        end
      elseif float_type == 'lazygit' then
        if vim.bo[state.buf].buftype ~= 'terminal' then
          vim.cmd.terminal 'lazygit'
          vim.cmd.startinsert()
        end
      end
    else
      -- Toggle window visibility
      local is_visible = vim.api.nvim_win_is_valid(state.win)
      if is_visible then
        vim.api.nvim_win_close(state.win, false)
        state.win = nil
      end
    end
  end
end

-- Create toggleable floating window and terminal functions
M.toggle_float_window = M.create_toggleable_float 'window'
M.toggle_float_terminal = M.create_toggleable_float 'terminal'
M.toggle_float_lazygit = M.create_toggleable_float 'lazygit'

-- Set up user commands
vim.api.nvim_create_user_command('Floatwin', M.toggle_float_window, {})
vim.api.nvim_create_user_command('Floaterm', M.toggle_float_terminal, {})
vim.api.nvim_create_user_command('FloatGit', M.toggle_float_lazygit, {})

-- return M
return M
