return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
    },
    config = function()
        local util = require('lspconfig.util')
        vim.lsp.enable('terraformls')

        vim.lsp.config('sqls', {
            -- This function tells the LSP where your project starts
            root_markers = { ".sqls.yml", ".git" },
        })

        vim.lsp.enable('sqls')
    end,
}
