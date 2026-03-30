-- lua/snippets/creator.lua
local M = {}

local snip_dir = vim.fn.stdpath 'config' .. '/snip'

local boilerplate = [[
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
}
]]

local function ensure_file(ft)
  vim.fn.mkdir(snip_dir, 'p')
  local path = snip_dir .. '/' .. ft .. '.lua'
  if vim.fn.filereadable(path) == 0 then
    local f = io.open(path, 'w')
    if f then
      f:write(boilerplate)
      f:close()
    end
  end
  return path
end

local function append_snippet(path, name, trigger, body_lines)
  local lines = vim.fn.readfile(path)

  local insert_line = nil
  for idx = #lines, 1, -1 do
    if lines[idx]:match '^}' then
      insert_line = idx
      break
    end
  end

  if not insert_line then
    vim.notify('Could not parse snippet file', vim.log.levels.ERROR)
    return
  end

  local entry
  if #body_lines == 1 then
    local escaped = body_lines[1]:gsub('\\', '\\\\'):gsub('"', '\\"')
    entry = string.format('  s({ trig = "%s", name = "%s" }, t("%s")),', trigger, name, escaped)
  else
    local parts = {}
    for i, line in ipairs(body_lines) do
      local escaped = line:gsub('\\', '\\\\'):gsub('"', '\\"')

      if i == 1 then
        table.insert(parts, string.format('t("%s")', escaped))
      else
        table.insert(parts, string.format('t({ "", "%s" })', escaped))
      end
    end

    entry = string.format('  s({ trig = "%s", name = "%s" }, { %s }),', trigger, name, table.concat(parts, ', '))
  end

  table.insert(lines, insert_line, entry)
  vim.fn.writefile(lines, path)
end

local function get_visual_lines()
  -- '< and '> are only updated after leaving visual mode,
  -- so we exit first via <Esc> before calling this.
  local start_line = vim.fn.line "'<"
  local end_line = vim.fn.line "'>"
  return vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
end

local function prompt_and_save(ft, body_lines)
  local path = ensure_file(ft)

  vim.ui.input({ prompt = 'Snippet name: ' }, function(name)
    if not name or name == '' then
      return
    end

    vim.ui.input({ prompt = 'Trigger: ' }, function(trigger)
      if not trigger or trigger == '' then
        return
      end

      append_snippet(path, name, trigger, body_lines)
      require('luasnip.loaders.from_lua').load { paths = snip_dir }

      vim.notify(string.format("[%s] snippet '%s' added (%d line%s)", ft, name, #body_lines, #body_lines > 1 and 's' or ''), vim.log.levels.INFO)
    end)
  end)
end

-- Normal mode: manually type the body
function M.create()
  local ft = vim.bo.filetype
  if ft == '' then
    vim.notify('No filetype detected', vim.log.levels.WARN)
    return
  end

  local path = ensure_file(ft)

  vim.ui.input({ prompt = 'Snippet name: ' }, function(name)
    if not name or name == '' then
      return
    end

    vim.ui.input({ prompt = 'Trigger: ' }, function(trigger)
      if not trigger or trigger == '' then
        return
      end

      vim.ui.input({ prompt = 'Body: ' }, function(body)
        if not body or body == '' then
          return
        end

        append_snippet(path, name, trigger, { body })
        require('luasnip.loaders.from_lua').load { paths = snip_dir }

        vim.notify(string.format("[%s] snippet '%s' added", ft, name), vim.log.levels.INFO)
      end)
    end)
  end)
end

-- Visual mode: selection becomes the body automatically
function M.create_from_visual()
  local ft = vim.bo.filetype
  if ft == '' then
    vim.notify('No filetype detected', vim.log.levels.WARN)
    return
  end

  -- Exit visual mode first so '< '> marks are committed
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'x', false)

  local body_lines = get_visual_lines()
  if #body_lines == 0 then
    vim.notify('Empty selection', vim.log.levels.WARN)
    return
  end

  prompt_and_save(ft, body_lines)
end

return M
