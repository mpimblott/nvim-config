return {
	"nvim-treesitter/nvim-treesitter",
	run = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})
		require("nvim-treesitter").install({ "python", "javascript", "lua" })
	end,
}
