local Servers = {
  -- C/C++
  clangd = {},

  -- Go
  gopls = {},

  -- Rust
  rust_analyzer = {},

  -- Web Dev
  html = {
    filetypes = { 'html', 'twig', 'hbs' }
  },
  cssls = {},
  angularls = {},

  -- Lua
  lua_ls = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      filetypes = { 'lua' },
    },
  },

  -- TypeScript/JavaScript - Updated to use vtsls (more modern alternative)
  vtsls = {
    settings = {
      vtsls = {
        enableMoveToFileCodeAction = true,
      },
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        suggest = {
          completeFunctionCalls = true,
        },
      },
    },
    filetypes = {
      'javascript',
      'typescript',
      'vue',
    },
  },

  -- Python
  basedpyright = {
    basedpyright = {
      analysis = {
        inlayHints = {
          variableTypes = true,
          functionReturnTypes = true,
          functionParameterTypes = true,
        },
      },
    },
    python = {
      analysis = {
        typeCheckingMode = "basic", -- can be "off", "basic", or "strict"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },

  -- Bash
  bashls = {
    filetypes = { 'sh', 'bash' },
  },
}


local Linters = {
  "prettier", -- prettier formatter
  "stylua",   -- lua formatter
  "isort",    -- python formatter
  "bibtex-tidy",
  "pylint",
  "clangd",
  "denols",
  "eslint_d",
  "black",
  "ruff",
}

return {
  "mason-org/mason.nvim",
  lazy = false,
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- "hrsh7th/cmp-nvim-lsp",
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
  },
  config = function()
    -- import mason and mason_lspconfig
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    -- NOTE: Moved these local imports below back to lspconfig.lua due to mason depracated handlers

    -- local lspconfig = require("lspconfig")
    -- local cmp_nvim_lsp = require("cmp_nvim_lsp")             -- import cmp-nvim-lsp plugin
    -- local capabilities = cmp_nvim_lsp.default_capabilities() -- used to enable autocompletion (assign to every lsp server config)

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- vim.notify("installing lsp for " .. vim.inspect(vim.tbl_keys(Servers)), vim.log.levels.INFO)
    mason_lspconfig.setup({
      automatic_enable = false,
      -- servers for mason to install
      ensure_installed = vim.tbl_keys(Servers),
    })


    mason_tool_installer.setup({
      ensure_installed = Linters,

      -- NOTE: mason BREAKING Change! Removed setup_handlers
      -- moved lsp configuration settings back into lspconfig.lua file
    })
  end,
  -- Function to get the installed servers
  get_installed_servers = function()
    -- concat the servers and the linters
    return Servers
  end,
  get_installed_linters = function()
    return Linters
  end,
}
