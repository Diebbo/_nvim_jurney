return {
    'jackMort/ChatGPT.nvim',
    event = 'VeryLazy',
    dependencies = {
        'MunifTanjim/nui.nvim',
        'nvim-lua/plenary.nvim',
        'folke/trouble.nvim',
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        local function is_env_file_missing()
            local home = os.getenv 'HOME'
            local env_file = home .. '/.config/nvim/.env'
            local file = io.open(env_file, 'r')
            if file then
                file:close()
                return false
            else
                return true
            end
        end

        local function get_api_key()
            local handle = io.popen 'pass show api/chatgpt/api_key'
            if handle then
                local api_key = handle:read('*a'):gsub('[\n\r]', '') -- Remove newline characters
                handle:close()
                return api_key
            else
                error "Failed to run 'pass' command"
            end
        end

        local function write_to_env_file(key, value)
            local home = os.getenv 'HOME'
            local env_file = home .. '/.config/nvim/.env'
            local file = io.open(env_file, 'r')
            local contents = ''
            local key_exists = false

            if file then
                contents = file:read '*all'
                file:close()
                for line in contents:gmatch '[^\r\n]+' do
                    if line:match('^' .. key .. '=') then
                        key_exists = true
                        break
                    end
                end
            end

            file = io.open(env_file, 'a+')
            if file then
                if not key_exists then
                    file:write(key .. '=' .. value .. '\n')
                end
                file:close()
            else
                error 'Failed to open .env file for writing'
            end
        end

        if is_env_file_missing() then
            local api_key = get_api_key()
            write_to_env_file('OPENAI_API_KEY', api_key)
        end

        require('chatgpt').setup {
            api_key_cmd = 'echo ' .. vim.fn.shellescape(api_key),
        }
    end,
}
