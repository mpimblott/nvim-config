return {
	"huggingface/llm.nvim",
	config = function()
		local llm = require("llm")

		local opts = {
			backend = "ollama",
			model = "qwen2.5-coder:0.5b",
			url = "http://localhost:11434/api/generate",

			accept_keymap = "<C-y>",
			dismiss_keymap = "<S-Tab>",

			-- Tokenizer is critical for context window management
			-- You can use a generic local tokenizer or download one
			tokenizer = {
				repository = "Qwen/Qwen2.5-Coder-0.5B",
			},

			request_body = {
				raw = true,
				options = {
					stop = { "\n", "\r\n" },
					num_predict = 80,
				},
			},

			-- "FIM" (Fill In Middle) allows the AI to see code *after* your cursor
			fim = {
				enabled = true,
				prefix = "<|fim_prefix|>",
				middle = "<|fim_middle|>",
				suffix = "<|fim_suffix|>",
			},

			context_window = 1024,
			enable_suggestions_on_startup = false,
			enable_suggestions_on_files = "*",
			lsp = {
				bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
			},
		}
        llm.setup(opts)

        -- toggle suggestions using the 'LLMToggleAutoSuggest' command
	end,
}
