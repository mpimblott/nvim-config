vim.g.mapleader = " " -- Use Space as your leader key
vim.g.maplocalleader = " "

-- SETTINGS: General behavior
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers (great for jumping)
vim.opt.mouse = "a"           -- Enable mouse support
-- Indentation
vim.opt.tabstop = 4           -- Tabs look like 4 spaces
vim.opt.shiftwidth = 4        -- Auto-indent uses 4 spaces
vim.opt.expandtab = true      -- Convert tabs to spaces
-- Search
vim.opt.ignorecase = true     -- Ignore case in search patterns
vim.opt.smartcase = true      -- ...unless there's a capital letter
-- UI
vim.opt.termguicolors = true  -- Better colors (standard in modern terminals)

-- Folding
vim.opt.foldminlines = 30
vim.opt.foldlevelstart = 1
-- Autoload changes
vim.o.autoread = true

-- Autocommand to run 'checktime' on specific events
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    command = "if mode() != 'c' | checktime | endif",
    pattern = { "*" },
})
vim.api.nvim_create_autocmd("FileChangedShellPost", {
    command = "echomsg 'File changed on disk. Buffer reloaded.'",
    pattern = { "*" },
})

-- KEYMAPS: Quality of life
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- Space+p+v opens the file explorer
vim.keymap.set("n", "<C-d>", "<C-d>zz")       -- snap cursor to centre of screen when navigating down
vim.keymap.set("n", "<C-u>", "<C-u>zz")       -- snap cursor to centre of screen when navigating up

-- Resize with Ctrl + Arrow Keys
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<leader>t", ":Toggleterm", { desc = "Open tab terminal" })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart Rename" })

require("config.lazy")

vim.diagnostic.config({ virtual_text = true })
vim.opt.signcolumn = "yes"

--  Set the delay (in milliseconds) before 'CursorHold' triggers
--  By default this is 4000ms (4 seconds). 1000ms = 1 second.
vim.opt.updatetime = 1000

--  Create the AutoSave command
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    callback = function()
        -- Only save if the buffer has a name and is modified
        if vim.fn.getbufinfo("%")[1].name ~= "" and vim.bo.modified then
            vim.cmd("silent! write")
            print("AutoSaved")
        end
    end,
})

vim.env.PATH = vim.env.PATH .. ":/home/linuxbrew/.linuxbrew/bin"

vim.filetype.add({
    extension = {
        yml = "yaml",
    },
})
