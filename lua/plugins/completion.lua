return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- Source for LSP (Python, etc)
            "hrsh7th/cmp-buffer",   -- Source for text in current file
            "hrsh7th/cmp-path",     -- Source for file system paths
            "L3MON4D3/LuaSnip",     -- Snippet engine (Required)
            "saadparwaiz1/cmp_luasnip", -- Snippet connector
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                -- 1. Snippet Engine (Required for nvim-cmp to work)
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                
                -- 2. Popups (Doc window borders)
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },

                -- 3. Key Mappings
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Scroll docs up
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),  -- Scroll docs down
                    ['<C-Space>'] = cmp.mapping.complete(),  -- Force open menu
                    ['<C-e>'] = cmp.mapping.abort(),         -- Close menu
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Enter to confirm
                    
                    -- Tab / Shift+Tab to cycle through list
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),

                -- 4. Sources (Order determines priority)
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' }, -- Data from Pyright/LSP
                    { name = 'luasnip' },  -- Snippets
                    { name = 'buffer' },   -- Words in current file
                    { name = 'path' },     -- File paths
                })
            })
        end,
    }
}
