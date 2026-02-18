return {
	"sindrets/diffview.nvim",
	version = "*",
	config = function()
		vim.keymap.set("n", "<leader>dvo", ":DiffviewOpen<cr>", { desc = "Open Diffview" })
        vim.keymap.set("n", "<leader>dvc", ":DiffviewClose<cr>", { desc = "Close Diffview" })
        vim.keymap.set("n", "<leader>dvh", ":DiffviewFileHistory<cr>", { desc = "Diffview file history" })
	end,
}
