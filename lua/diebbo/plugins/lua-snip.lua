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




      ls.add_snippets("r", {
        s("ARalgorithm", {
          t(
            { "ARalgorithm <- function(n, f, g, rg, m, report = TRUE) {",
              "\tx <- rep(0, n)",
              "\tntry <- 0",
              "\tfor (i in 1:n) {",
              "\t\tdone <- FALSE",
              "\t\twhile (!done) {",
              "\t\t\tntry <- ntry + 1",
              "\t\t\ty <- rg(x)",
              "\t\t\tif (f(y) / (g(y) * m) <= 1) {",
              "\t\t\t\tx <- y",
              "\t\t\t\tdone <- TRUE",
              "\t\t\t}",
              "\t}",
              "\tif (report) {",
              "\t\tcat(\"ntry = \", ntry, \"n\")",
              "\t}",
              "\treturn(x)",
              "}" }),
          i(0),
        }),
        s("MCInt", { -- Monte Carlo Integration
          t(
            {
              "Nsim <- 10^3",
              "x=sample(Nsim)",
              "hn <- mean(h(x))",
              "err <- mean((h(x)-hn)^2)/Nsim",
            }),
        }),
        s("imp-sampling", {
          t(
            {
              "Nsim <- 10^4",
              "y <- rg(Nsim)",
              "weit <- h(y)/g(y)",
              "is <- mean(f(y) * weit)",
              "err_is <- mean((f(y) * weit - is)^2)/Nsim",
              "is_plot <- cumsum(f(y)*weit)/(1:Nsim)",
              "par(mfrow=c(2,1))",
              "hist(y, col=\"lightblue\", border=\"white\")",
              "plot(is_plot, type=\"l\")",
              "lines(is_plot + 2 * err_is, col=\"purple\", add=T, lwd = 0.5, lty = 2)",
              "lines(is_plot - 2 * err_is, col=\"red\", add=T, lwd = 0.5, lty = 2)",
            }
          ),
        })
      })


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
