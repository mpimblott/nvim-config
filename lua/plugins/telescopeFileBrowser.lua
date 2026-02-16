return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            extensions = {
                file_browser = {
                    -- theme = "ivy", (optional: change the look)
                    -- hijack_netrw = true,
                },
            },
        })

        telescope.load_extension("file_browser")

        --vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
    end,
}
