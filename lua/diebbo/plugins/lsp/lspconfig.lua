return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'saghen/blink.cmp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
    'masonorg/mason-lspconfig.nvim',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = desc })
        end

        print('LSP attached to buffer: ' .. ev.buf)

        -- Set some keymaps for LSP
        nmap('<leader>ll', function()
          vim.cmd 'LspLog'
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
          print 'Added workspace folder'
        end, '[W]orkspace [A]dd Folder')

        nmap('<leader>wr', function()
          vim.lsp.buf.remove_workspace_folder()
          print 'Removed workspace folder'
        end, '[W]orkspace [R]emove Folder')

        nmap('<leader>wl', function()
          local folders = vim.lsp.buf.list_workspace_folders()
          if #folders == 0 then
            print 'No workspace folders'
          else
            print 'Workspace folders:'
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
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = '󰠠 ',
      [vim.diagnostic.severity.INFO] = ' ',
    }

    -- Set the diagnostic config with all icons
    vim.diagnostic.config {
      signs = {
        text = signs, -- Enable signs in the gutter
      },
      virtual_text = true, -- Specify Enable virtual text for diagnostics
      underline = true, -- Specify Underline diagnostics
      update_in_insert = false, -- Keep diagnostics active in insert mode
    }

    -- ( comment the ones in mason )
    local lspconfig = require 'lspconfig'
    local capabilities = require('blink.cmp').get_lsp_capabilities() -- Import capabilities from blink.cmp

    -- get the servers table from mason
    local Servers = require('diebbo.plugins.lsp.mason').get_installed_servers()

    -- Loop through each server and set it up
    for server_name, server_config in pairs(Servers) do
      lspconfig[server_name].setup {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Disable formatting if you're using a separate formatter like Prettier
          client.server_capabilities.documentFormattingProvider = false
        end,
        settings = server_config or {},
      }
    end
  end,
}
