return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
    },
    config = function()
        -- For sqls create a file: ~/.config/sqls/config.yml
        -- Use the new Neovim 0.11+ API to avoid deprecation warnings
        
        -- Configure sqls with filetype restrictions and root markers
        vim.lsp.config('sqls', {
            filetypes = { 'sql', 'mysql', 'plsql' },
            root_markers = { ".sqls.yml", ".git" },
        })

        -- Enable the LSPs
        vim.lsp.enable('terraformls')
        vim.lsp.enable('basedpyright')
        vim.lsp.enable('clangd')
        vim.lsp.enable('lua_ls')
        vim.lsp.enable('ts_ls')
        vim.lsp.enable('sqls')
    end,
}
