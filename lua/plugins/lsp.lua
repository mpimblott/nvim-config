return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    -- Configure mason-lspconfig to set up terraformls
    mason_lspconfig.setup({
      ensure_installed = { "terraformls" },
      handlers = {
        ["terraformls"] = function()
          require("lspconfig").terraformls.setup({
            -- Add any terraformls specific settings here if needed
          })
        end,
      },
    })
  end,
}