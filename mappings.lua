local M = {}

--[[function CompileProject()
    -- Clear the quickfix list
    vim.fn.setqflist({}, 'r')

    -- Get the current directory
    local dir = vim.fn.getcwd()

    -- Set the build script
    local make_cmd = "build.bat"

    -- Set the current file
    local current_file = vim.fn.expand('%:p')
    local output_file = vim.fn.expand('%:p:r');

    -- Check if build.bat exists, if not, try using make
    if vim.fn.filereadable(dir .. "/build.bat") == 0 then
        if vim.fn.filereadable(dir .. "/Makefile") == 1 then
            make_cmd = "make"
        else
            make_cmd = 'gcc "' .. current_file .. '" -o "' .. output_file .. '" && "' .. output_file .. '.exe"'
        end
    end

    -- Display a message
    print("Compiling project in " .. dir .. " using " .. make_cmd)

    -- Create the job
    local job_id = vim.fn.jobstart(make_cmd, {
        cwd = dir,
        on_stdout = function(_, data, _)
            if data then
                -- Process data to remove carriage returns
                local cleaned_data = {}
                for _, line in ipairs(data) do
                    -- Replace \r with empty string
                    local clean_line = string.gsub(line, "\r", "")
                    table.insert(cleaned_data, clean_line)
                end
                vim.fn.setqflist({}, 'a', { lines = cleaned_data })
            end
        end,
        on_stderr = function(_, data, _)
            if data then
                -- Process data to remove carriage returns
                local cleaned_data = {}
                for _, line in ipairs(data) do
                    -- Replace \r with empty string
                    local clean_line = string.gsub(line, "\r", "")
                    table.insert(cleaned_data, clean_line)
                end
                vim.fn.setqflist({}, 'a', { lines = cleaned_data })
            end
        end,
        on_exit = function(_, exitcode, _)
            if exitcode == 0 then
                print("Build completed successfully")
                -- Only open quickfix on error by default
                -- vim.cmd("copen")
            else
                print("Build failed with exit code: " .. exitcode)
                vim.cmd("copen")
            end
        end,
    })

    if job_id <= 0 then
        print("Failed to start build job")
    end
end]]

local M = {}

function CompileProject()
    -- Clear the quickfix list
    vim.fn.setqflist({}, 'r')
    -- Get the current directory
    local dir = vim.fn.getcwd()
    -- Get current file info
    local current_file = vim.fn.expand('%:p')
    local output_file = vim.fn.expand('%:p:r')
    local file_name = vim.fn.expand('%:t:r')
    -- Set the build script
    local make_cmd = "build.bat"
    local run_cmd = nil

    -- Check if build.bat exists, if not, try using make
    if vim.fn.filereadable(dir .. "/build.bat") == 0 then
        if vim.fn.filereadable(dir .. "/Makefile") == 1 then
            make_cmd = "make"
        else
            make_cmd = 'gcc "' .. current_file .. '" -o "' .. output_file .. '"'
            run_cmd = '"' .. output_file .. '.exe"'
        end
    end

    -- Display a message
    print("Compiling project in " .. dir .. " using " .. make_cmd)

    -- Create the job
    local job_id = vim.fn.jobstart(make_cmd, {
        cwd = dir,
        on_stdout = function(_, data, _)
            if data then
                -- Process data to remove carriage returns
                local cleaned_data = {}
                for _, line in ipairs(data) do
                    -- Replace \r with empty string
                    local clean_line = string.gsub(line, "\r", "")
                    table.insert(cleaned_data, clean_line)
                end
                vim.fn.setqflist({}, 'a', { lines = cleaned_data })
            end
        end,
        on_stderr = function(_, data, _)
            if data then
                -- Process data to remove carriage returns
                local cleaned_data = {}
                for _, line in ipairs(data) do
                    -- Replace \r with empty string
                    local clean_line = string.gsub(line, "\r", "")
                    table.insert(cleaned_data, clean_line)
                end
                vim.fn.setqflist({}, 'a', { lines = cleaned_data })
            end
        end,
        on_exit = function(_, exitcode, _)
            if exitcode == 0 then
                print("Build completed successfully")
                -- Only open quickfix on error by default
                -- vim.cmd("copen")

                -- Run the executable if we're compiling a single file
                if run_cmd then
                    print("Running executable: " .. run_cmd)
                    -- Open a terminal buffer to run the executable
                    vim.cmd('belowright split | terminal ' .. run_cmd)
                end
            else
                print("Build failed with exit code: " .. exitcode)
                vim.cmd("copen")
            end
        end,
    })

    if job_id <= 0 then
        print("Failed to start build job")
    end
end

-- Set up key mappings
function SetupCompileMappings()
    -- F5 to compile
    vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua CompileProject()<CR>', { noremap = true, silent = true})
    -- Navigate through errors in quickfix
    vim.api.nvim_set_keymap('n', '<F6>', '<cmd>cnext<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<F7>', '<cmd>cprev<CR>', { noremap = true, silent = true })
    -- Toggle quickfix window
    vim.api.nvim_set_keymap('n', '<F8>', '<cmd>copen<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<F9>', '<cmd>cclose<CR>', { noremap = true, silent = true })
end

-- Call the setup functions
SetupCompileMappings()

-- Setup error format
vim.cmd([[
  set errorformat=%f:%l:%c:\ %t%*[^:]:\ %m,%f:%l:\ %t%*[^:]:\ %m
  set errorformat+=%f(%l):\ %m
  set errorformat+=%f:%l:%m
  set errorformat+=%f\|%l\|\ %m
]])

-- Handle Windows line endings in quickfix
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "quickfix",
  callback = function()
    vim.cmd([[set ffs=dos,unix]])
    vim.cmd([[silent! %s/\r$//g]])
  end
})

-- Set default file format to dos for Windows
vim.opt.fileformats = "dos,unix"

-- Add these after your existing indent options
vim.opt.cindent = true  -- Enable C-style indentation
vim.opt.cinoptions = "{1s,}1s,^1s,L1"  -- Control brace placement

-- Or if you want it only for C/C++ files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
        vim.opt_local.cindent = true
        vim.opt_local.cinoptions = "{1s,}1s,^1s,L1"
    end
})

-- Configure how special characters are displayed
vim.opt.listchars = { eol = '↵', tab = '→ ', trail = '·', extends = '…', precedes = '…' }
vim.opt.list = false  -- Set to true if you want to see special characters

-- Custom highlight for C TODO keywords
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp"},
    callback = function()
        vim.api.nvim_set_hl(0, "cTodo", { fg = "#FF0000", bold = true })
        vim.api.nvim_set_hl(0, "cNote", { fg = "#008000", bold = true })
        vim.api.nvim_set_hl(0, "cImportant", { fg = "#FFFF00", bold = true })
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp"},
    callback = function()
    end
})

return M
