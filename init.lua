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
