return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        --"hrsh7th/cmp-nvim-lsp",
        "saghen/blink.cmp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        -- NOTE: LSP Keybinds

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)

        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = desc })
        end

        print('LSP attached to buffer: ' .. ev.buf )

        -- Set some keymaps for LSP
        nmap('<leader>ll', function()
          vim.cmd('LspLog')
        end, '[L]SP [L]og')

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        nmap('<leader>lds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>lws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Workspace functionality - these should work now
        nmap('<leader>wa', function()
          vim.lsp.buf.add_workspace_folder()
          print('Added workspace folder')
        end, '[W]orkspace [A]dd Folder')

        nmap('<leader>wr', function()
          vim.lsp.buf.remove_workspace_folder()
          print('Removed workspace folder')
        end, '[W]orkspace [R]emove Folder')

        nmap('<leader>wl', function()
          local folders = vim.lsp.buf.list_workspace_folders()
          if #folders == 0 then
            print('No workspace folders')
          else
            print('Workspace folders:')
            for i, folder in ipairs(folders) do
              print('  ' .. i .. ': ' .. folder)
            end
          end
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(ev.buf, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end,
    })


        -- NOTE : Moved all this to Mason including local variables
        -- used to enable autocompletion (assign to every lsp server config)
        -- local capabilities = cmp_nvim_lsp.default_capabilities()
        -- Change the Diagnostic symbols in the sign column (gutter)

        -- Define sign icons for each severity
        local signs = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰠠 ",
            [vim.diagnostic.severity.INFO]  = " ",
        }

        -- Set the diagnostic config with all icons
        vim.diagnostic.config({
            signs = {
                text = signs -- Enable signs in the gutter
            },
            virtual_text = true,  -- Specify Enable virtual text for diagnostics
            underline = true,     -- Specify Underline diagnostics
            update_in_insert = false,  -- Keep diagnostics active in insert mode
        })

        -- HACK: If using Blink.cmp Configure all LSPs here

        -- ( comment the ones in mason )
        local lspconfig = require("lspconfig")
        local capabilities = require("blink.cmp").get_lsp_capabilities() -- Import capabilities from blink.cmp

        -- Configure lua_ls
         lspconfig.lua_ls.setup({
             capabilities = capabilities,
             settings = {
                 Lua = {
                     diagnostics = {
                         globals = { "vim" },
                     },
                     completion = {
                         callSnippet = "Replace",
                     },
                     workspace = {
                         library = {
                             [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                             [vim.fn.stdpath("config") .. "/lua"] = true,
                         },
                     },
                 },
             },
         })
        --
        -- -- Configure tsserver (TypeScript and JavaScript)
        -- lspconfig.ts_ls.setup({
        --     capabilities = capabilities,
        --     root_dir = function(fname)
        --         local util = lspconfig.util
        --         return not util.root_pattern('deno.json', 'deno.jsonc')(fname)
        --             and util.root_pattern('tsconfig.json', 'package.json', 'jsconfig.json', '.git')(fname)
        --     end,
        --     single_file_support = false,
        --     on_attach = function(client, bufnr)
        --         -- Disable formatting if you're using a separate formatter like Prettier
        --         client.server_capabilities.documentFormattingProvider = false
        --     end,
        --     init_options = {
        --         preferences = {
        --             includeCompletionsWithSnippetText = true,
        --             includeCompletionsForImportStatements = true,
        --         },
        --     },
        -- })

        -- Add other LSP servers as needed, e.g., gopls, eslint, html, etc.
        -- lspconfig.gopls.setup({ capabilities = capabilities })
        -- lspconfig.html.setup({ capabilities = capabilities })
        -- lspconfig.cssls.setup({ capabilities = capabilities })
    end,
}
--   return {
--   -- LSP Configuration & Plugins
--   "neovim/nvim-lspconfig",
--   event = { "BufReadPre", "BufNewFile" },
--   dependencies = {
--     "saghen/blink.cmp",
--     { "antosha417/nvim-lsp-file-operations", config = true },
--   },
--   config = function()
--     -- [[ Configure LSP ]]
--     --  This function gets run when an LSP connects to a particular buffer.
--   vim.api.nvim_create_autocmd("LspAttach", {
--     group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--     callback = function(ev)
--       local nmap = function(keys, func, desc)
--         if desc then
--           desc = 'LSP: ' .. desc
--         end
--
--         vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--       end
--
--       print('LSP attached to buffer: ' .. bufnr .. ' (client: ' .. client.name .. ')')
--
--       -- Set some keymaps for LSP
--       nmap('<leader>ll', function()
--         vim.cmd('LspLog')
--       end, '[L]SP [L]og')
--
--       nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--       nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--
--       nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
--       nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--       nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
--       nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
--       nmap('<leader>lds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--       nmap('<leader>lws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--
--       -- See `:help K` for why this keymap
--       nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--       nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
--
--       -- Lesser used LSP functionality
--       nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--
--       -- Workspace functionality - these should work now
--       nmap('<leader>wa', function()
--         vim.lsp.buf.add_workspace_folder()
--         print('Added workspace folder')
--       end, '[W]orkspace [A]dd Folder')
--
--       nmap('<leader>wr', function()
--         vim.lsp.buf.remove_workspace_folder()
--         print('Removed workspace folder')
--       end, '[W]orkspace [R]emove Folder')
--
--       nmap('<leader>wl', function()
--         local folders = vim.lsp.buf.list_workspace_folders()
--         if #folders == 0 then
--           print('No workspace folders')
--         else
--           print('Workspace folders:')
--           for i, folder in ipairs(folders) do
--             print('  ' .. i .. ': ' .. folder)
--           end
--         end
--       end, '[W]orkspace [L]ist Folders')
--
--       -- Create a command `:Format` local to the LSP buffer
--       vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--         vim.lsp.buf.format()
--       end, { desc = 'Format current buffer with LSP' })
--     end
--
--     vim.api.nvim_create_autocmd("LspAttach", {
--       group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--       callback = function(ev)
--         on_attach(ev.data.client, ev.buf)
--       end
--     })
--
--     -- document existing key chains
--     require('which-key').add({
--       { '<leader>c', desc = '[C]ode' },
--       { '<leader>d', desc = '[D]ocument' },
--       { '<leader>g', desc = '[G]it' },
--       { '<leader>h', desc = 'More git' },
--       { '<leader>r', desc = '[R]ename' },
--       { '<leader>s', desc = '[S]earch' },
--       { '<leader>w', desc = '[W]orkspace' },
--       { '<leader>l', desc = '[L]SP' },
--     })
--
--     -- Setup neovim lua configuration
--     require('neodev').setup()
--
--     -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
--     local capabilities = require('blink.cmp').get_lsp_capabilities()
--     local lspconfig = require('lspconfig')
--
--     vim.diagnostic.config({
--       signs = {
--         text = signs            -- Enable signs in the gutter
--       },
--       virtual_text = true,      -- Specify Enable virtual text for diagnostics
--       underline = true,         -- Specify Underline diagnostics
--       update_in_insert = false, -- Keep diagnostics active in insert mode
--     })
--
--     -- Assuming you have a Servers table defined in another file
--     Servers = {
--       -- C/C++
--       clangd = {},
--
--       -- Go
--       gopls = {},
--
--       -- Rust
--       rust_analyzer = {},
--
--       -- Web Dev
--       html = {
--         filetypes = { 'html', 'twig', 'hbs' }
--       },
--       cssls = {},
--       angularls = {},
--
--       -- Lua
--       lua_ls = {
--         Lua = {
--           runtime = {
--             -- Tell the language server which version of Lua you're using
--             -- (most likely LuaJIT in the case of Neovim)
--             version = 'LuaJIT',
--           },
--           diagnostics = {
--             -- Get the language server to recognize the `vim` global
--             globals = {
--               'vim',
--               'require'
--             },
--           },
--           workspace = {
--             -- Make the server aware of Neovim runtime files
--             library = vim.api.nvim_get_runtime_file("", true),
--           },
--           -- Do not send telemetry data containing a randomized but unique identifier
--           telemetry = {
--             enable = false,
--           },
--           filetypes = { 'lua' },
--         },
--       },
--
--       -- TypeScript/JavaScript - Updated to use vtsls (more modern alternative)
--       vtsls = {
--         settings = {
--           vtsls = {
--             enableMoveToFileCodeAction = true,
--           },
--           typescript = {
--             updateImportsOnFileMove = { enabled = "always" },
--             suggest = {
--               completeFunctionCalls = true,
--             },
--           },
--         },
--         filetypes = {
--           'javascript',
--           'typescript',
--           'vue',
--         },
--       },
--
--       -- Python
--       basedpyright = {},
--
--       -- Bash
--       bashls = {
--         filetypes = { 'sh', 'bash' },
--       },
--     }
--
--     vim.notify(Servers)
--     for server_name, server_config in pairs(Servers) do
--       lspconfig[server_name].setup({
--         capabilities = capabilities,
--         on_attach = on_attach,
--         settings = server_config or {},
--         filetypes = server_config.filetypes or {},
--       })
--       vim.notify('Configured LSP server: ' .. server_name, vim.log.levels.INFO)
--     end
--
--     -- Debug command to check LSP status
--     vim.api.nvim_create_user_command('LspDebug', function()
--       local clients = vim.lsp.get_clients()
--       if #clients == 0 then
--         print('No LSP clients attached')
--       else
--         print('Active LSP clients:')
--         for _, client in ipairs(clients) do
--           print('  - ' .. client.name .. ' (id: ' .. client.id .. ')')
--         end
--       end
--     end, { desc = 'Debug LSP status' })
--   end
--     })
-- }
