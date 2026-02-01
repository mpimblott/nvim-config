1. Docker & Ollama Setup
First, we set up the inference server. We use Docker to keep the system clean and ensure the server restarts automatically.

A. Run the Container
Run this command to start Ollama in the background. It maps port 11434 to your host and creates a volume to save your models.

Bash
docker run -d \
  --name ollama \
  --restart always \
  -v ollama:/root/.ollama \
  -p 11434:11434 \
  ollama/ollama
B. Pull the Model
We use Qwen 2.5 Coder (1.5B). It is small enough to run fast on integrated graphics but smart enough to understand context.

Important: You must use the coder variant, not the standard chat model.

Bash
docker exec -it ollama ollama pull qwen2.5-coder:1.5b
C. Verify Connection
Run this command from your terminal to ensure Neovim can see the server:

Bash
curl http://localhost:11434/api/tags
You should see a JSON response listing qwen2.5-coder:1.5b.

2. Neovim Configuration (llm.nvim)
Install huggingface/llm.nvim using your plugin manager (Lazy.nvim).

Key Features of this Config:

raw = true: Forces the model to just write code, preventing it from acting like a Chatbot ("Here is your python code...").

stop = { "\n" }: Forces single-line completion only.

accept_keymap: Binds acceptance to Ctrl+Enter (or Ctrl+J) so your Tab key still works for indentation.

lazy = false: Forces the plugin to load immediately so ghost text works right away.

Lua
return {
    "huggingface/llm.nvim",
    lazy = false, -- Force load immediately
    opts = {
        backend = "ollama",
        model = "qwen2.5-coder:1.5b",
        url = "http://localhost:11434/api/generate",
        
        -- KEYMAPS
        accept_keymap = "<C-CR>",   -- Ctrl + Enter to accept (Try <C-J> if this fails)
        dismiss_keymap = "<S-Tab>", -- Shift + Tab to dismiss
        
        tokenizer = {
            repository = "Qwen/Qwen2.5-Coder-1.5B",
        },
        
        -- REQUEST PARAMETERS
        request_body = {
            -- Tell Ollama to ignore the "User/Assistant" chat template
            raw = true, 
            
            options = {
                num_predict = 80,       -- Safety limit (max tokens)
                stop = { "\n", "\r\n" }, -- Stop generating at a new line
                temperature = 0.2,       -- Low temp = more accurate/robotic
            },
        },

        fim = {
            enabled = true,
            prefix = "<|fim_prefix|>",
            middle = "<|fim_middle|>",
            suffix = "<|fim_suffix|>",
        },

        context_window = 1024, -- Keep low (1024) for speed on integrated graphics
        enable_suggestions_on_startup = true,
        enable_suggestions_on_files = "*",
        
        -- Point to the binary installed by Mason
        lsp = {
             bin_path = vim.fn.stdpath("data") .. "/mason/bin/llm-ls",
        },
    },
}
3. Usage & Troubleshooting
How to use
Type Code: Start typing a function or variable. Pause for a split second.

See Ghost Text: Gray text will appear suggesting the completion.

Accept: Press Ctrl + Enter.

Reject: Keep typing; the suggestion will disappear.

Troubleshooting
"The model is chatting with me instead of coding" Ensure raw = true is in your request_body. If it persists, create a custom Modelfile to strip the system prompt (see below).

"Ctrl+Enter creates a new line instead of accepting" Your terminal is likely swallowing the Ctrl+Enter key code.

Fix: Change accept_keymap to "<C-y>" (Ctrl+y) or "<M-CR>" (Alt+Enter).

"I see no completions"

Run :LspInfo. Check if llm-ls is attached.

Check the logs: :lua vim.cmd('e ' .. vim.lsp.get_log_path()).

Ensure the model name in Lua matches the Docker output exactly (colons and hyphens matter).

Optional: The "Chatty Model" Hard Fix
If raw = true fails and the model keeps "talking," create a custom model wrapper:

Create a file named Modelfile:

Dockerfile
FROM qwen2.5-coder:1.5b
TEMPLATE "{{ .Prompt }}"
SYSTEM ""
Run: docker exec -it ollama ollama create qwen-silent -f Modelfile

Update Lua config: model = "qwen-silent"
