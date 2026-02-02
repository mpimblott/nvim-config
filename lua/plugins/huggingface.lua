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
			enable_suggestions_on_startup = true,
			enable_suggestions_on_files = "*",
			lsp = {
				bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
			},
		}
        llm.setup(opts)

		local suggestions_active = opts.enable_suggestions_on_startup

		local function toggle_llm()
			suggestions_active = not suggestions_active
			llm.setup({ enable_suggestions_on_startup = suggestions_active })

			local status = suggestions_active and "Enabled" or "Disabled"
			vim.notify("LLM Completions " .. status, vim.log.levels.INFO, { title = "llm.nvim" })
		end

		vim.keymap.set("n", "<leader>lt", toggle_llm, { desc = "Toggle LLM Completions" })
	end,
}
