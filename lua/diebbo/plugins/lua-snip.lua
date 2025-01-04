return {
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
      local ls = require 'luasnip'
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local extras = require("luasnip.extras")
      local rep = extras.rep -- for multiple cursor eg. begin curson in tex
      local fmt = require("luasnip.extras.fmt").fmt
      -- local f = ls.function_node -- for dynamic snippets
      -- https://www.youtube.com/watch?v=FmHhonPjvvA


      ls.add_snippets("lua", {
        s("hello2", {
          t('print("Hello'),
          i(1),
          t('" world'),
          i(0),
          t('")')
        }),
      })

      ls.add_snippets("tex", {
        --   s("beg", {
        --     t("\\begin{"),
        --     i(1),
        --     t("}"),
        --     i(0),
        --     t("\\end{"),
        --     rep(1),
        --     t("}")
        --   }),
        s("beg", fmt(
          [[
          \begin{{{}}}
            {}
          \end{{{}}}
          ]], {
            i(1), i(0), rep(1)
          }))
      })


      -- keybindings
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      map('i', '<C-j>', [[<cmd>lua require'luasnip'.jump(1)<CR>]], opts)
      map('i', '<C-k>', [[<cmd>lua require'luasnip'.jump(-1)<CR>]], opts)
    end,
  }
}
