local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local extras = require 'luasnip.extras'
local rep = extras.rep -- for multiple cursor eg. begin curson in tex
local fmt = require('luasnip.extras.fmt').fmt
-- local f = ls.function_node -- for dynamic snippets
-- https://www.youtube.com/watch?v=FmHhonPjvvA

ls.add_snippets('typst', {
  -- automatic snippet
  -- make inline formula
  s({ snippetType="autosnippet", trig = 'mk', wordTrig = false, regTrig = false }, {
    t '$',
    i(1, 'formula'),
    t '$',
    i(0),
  }),

  -- make display formula
  s('dm', {
    t '$ ',
    i(1, 'formula'),
    t ' $',
    i(0),
  }),
})

ls.add_snippets('lua', {
  s('hello2', {
    t 'print("Hello',
    i(1),
    t '" world',
    i(0),
    t '")',
  }),
})

ls.add_snippets('tex', {
  --   s("beg", {
  --     t("\\begin{"),
  --     i(1),
  --     t("}"),
  --     i(0),
  --     t("\\end{"),
  --     rep(1),
  --     t("}")
  --   }),
  s(
    'beg',
    fmt(
      [[
          \begin{{{}}}
            {}
          \end{{{}}}
          ]],
      {
        i(1),
        i(0),
        rep(1),
      }
    )
  ),
})

ls.add_snippets('markdown', {
  s({ trig = 'table(%d+)x(%d+)', regTrig = true }, {
    d(1, function(args, snip)
  local nodes = {}
  local i_counter = 0
  local hlines = ''
  for _ = 1, snip.captures[2] do
    i_counter = i_counter + 1
    table.insert(nodes, t '| ')
    table.insert(nodes, i(i_counter, 'Column' .. i_counter))
    table.insert(nodes, t ' ')
    hlines = hlines .. '|---'
  end
  table.insert(nodes, t { '|', '' })
  hlines = hlines .. '|'
  table.insert(nodes, t { hlines, '' })
  for _ = 1, snip.captures[1] do
    for _ = 1, snip.captures[2] do
      i_counter = i_counter + 1
      table.insert(nodes, t '| ')
      table.insert(nodes, i(i_counter))
      print(i_counter)
      table.insert(nodes, t ' ')
    end
    table.insert(nodes, t { '|', '' })
  end
  return sn(nil, nodes)
    end),
  }),
})
