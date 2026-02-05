return {
	"L3MON4D3/LuaSnip",
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		-- Load the pre-made snippets
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}
