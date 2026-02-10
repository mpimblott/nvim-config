return {
	"sindrets/diffview.nvim",
	version = "*",
	config = function()
		vim.keymap.set("n", "<leader>do", ":DiffviewOpen<cr>", { desc = "Open Diffview" })
        vim.keymap.set("n", "<leader>dc", ":DiffviewClose<cr>", { desc = "Close Diffview" })
	end,
}
