local map = vim.keymap.set

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

map("n", "<leader>th", function()
  require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- new terminals
map("n", "<leader>h", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

map("n", "<leader>v", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical term" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

function CompileProject()
    -- Clear the quickfix list
    vim.fn.setqflist({}, 'r')

    -- Get the current directory
    local dir = vim.fn.getcwd()

    -- Set the build script
    local make_cmd = "build.bat"

    -- Check if build.bat exists, if not, try using make
    if vim.fn.filereadable(dir .. "/build.bat") == 0 then
        if vim.fn.filereadable(dir .. "/Makefile") == 1 then
            make_cmd = "make"
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

--  set errorformat+=%f(%l):%m
-- Add this to your mappings.lua without modifying the quickfix buffer itself
--[[vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    -- Use the cc command to jump to the error under cursor
    vim.keymap.set("n", "<CR>", function()
      local qf_idx = vim.fn.line(".")
      -- Close quickfix window first
      vim.cmd("cclose")
      -- Jump to the error
      vim.cmd("cc " .. qf_idx)
    end, { buffer = true, noremap = true })
  end
})]]

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

-- Configure how special characters are displayed
vim.opt.listchars = { eol = '↵', tab = '→ ', trail = '·', extends = '…', precedes = '…' }
vim.opt.list = false  -- Set to true if you want to see special characters
