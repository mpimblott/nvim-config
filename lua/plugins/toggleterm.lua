return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = 20,
            open_mapping = [[<c-\>]],
            direction = "horizontal",
            float_opts = {
                border = "curved",
                title_pos = "center"
            },
            start_in_insert = true,
            winbar = {
                enabled= true,
                name_formatter = function(term)
                    return "Terminal ".. term.id
                end
            }
        })

        -- Custom keymaps (optional but recommended)
        function _G.set_terminal_keymaps()
            local opts = {buffer = 0}

            local term_name = vim.api.nvim_buf_get_name(0)

            -- this is needed to allow escape to function properly inside lazygit
            if string.find(term_name, "lazygit") then
                vim.keymap.set('t', '<C-q>', [[<C-\><C-n>]], opts)
            else
                vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
            end

            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        end
        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end
}
