-- SETTINGS: General behavior
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Relative line numbers (great for jumping)
vim.opt.mouse = 'a'            -- Enable mouse support
-- Indentation
vim.opt.tabstop = 4            -- Tabs look like 4 spaces
vim.opt.shiftwidth = 4         -- Auto-indent uses 4 spaces
vim.opt.expandtab = true       -- Convert tabs to spaces
-- Search
vim.opt.ignorecase = true       -- Ignore case in search patterns
vim.opt.smartcase = true        -- ...unless there's a capital letter
-- UI
vim.opt.termguicolors = true   -- Better colors (standard in modern terminals)

-- KEYMAPS: Quality of life
vim.g.mapleader = " "          -- Use Space as your leader key
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex) -- Space+p+v opens the file explorer

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
        if vim.fn.getbufinfo('%')[1].name ~= "" and vim.bo.modified then
            vim.cmd("silent! write")
            print("AutoSaved")
        end
    end,
})
