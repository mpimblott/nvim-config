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

        -- Configure denols and ts_ls root markers
        vim.lsp.config('denols', {
            root_markers = { 'deno.json', 'deno.jsonc' },
        })

        vim.lsp.config('ts_ls', {
            root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
        })

        -- Enable the LSPs
        vim.lsp.enable('terraformls')
        vim.lsp.enable('basedpyright')
        vim.lsp.enable('clangd')
        vim.lsp.enable('lua_ls')
        vim.lsp.enable('sqls')

        -- Conditional TypeScript/Deno setup
        local is_deno = vim.fs.root(0, { "deno.json", "deno.jsonc" }) ~= nil

        if is_deno then
            vim.lsp.enable('denols')
        else
            vim.lsp.enable('ts_ls')
        end
    end,
}
