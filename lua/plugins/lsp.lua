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
        vim.lsp.config('postgres_lsp', {
            filetypes = { 'sql', 'psql' },
            root_markers = { ".git" },
            settings = {
                postgres_lsp = {
                    connectionString = "postgresql://postgres:postgres@127.0.0.1:54322/postgres"
                }
            }
        })
        -- vim.lsp.config('sqls', {
        -- filetypes = { 'sql', 'mysql', 'plsql' },
        -- root_markers = { ".sqls.yml", ".git" },
        -- cmd = {"sqls", "-config", "~/.config/sqls/config.yml"}
        -- })

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

        vim.lsp.config('denols', {
            root_markers = { 'deno.json', 'deno.jsonc' },
            settings = {
                deno = {
                    enable = true,
                    -- Deno resolves this relative to the matched root_marker directory!
                    config = "./deno.json",
                    suggest = {
                        imports = {
                            hosts = {
                                ["https://deno.land"] = true
                            }
                        }
                    }
                }
            }
        })

        -- 2. Configure ts_ls to IGNORE Deno directories
        -- vim.lsp.config('ts_ls', {
        -- root_dir = function(bufnr)
        -- -- If we are in a Deno project, return nil so ts_ls backs off
        -- if vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' }) then
        -- return nil
        -- end
        -- -- Otherwise, attach to normal Node/TS projects
        -- return vim.fs.root(bufnr, { 'package.json', 'tsconfig.json', '.git' })
        -- end,
        -- })

        -- Conditional TypeScript/Deno setup
        local is_deno = vim.fs.root(0, { "deno.json", "deno.jsonc" }) ~= nil

        if is_deno then
            vim.lsp.enable('denols')
        else
            vim.lsp.enable('ts_ls')
        end
    end,
}
