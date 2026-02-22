return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap-python",
		"nvim-neotest/nvim-nio", -- Required for dap-ui
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_python = require("dap-python")

		-- 1. Setup the UI (Standard VS Code style layout)
		dapui.setup()

		-- 2. Connect Mason's debugpy to nvim-dap
		-- Mason installs debugpy in a specific folder. We point the plugin there.
		-- Windows users might need to adjust "bin/python" to "Scripts/python"
		local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
		dap_python.setup(debugpy_path)

		-- 3. Auto-open the UI when debugging starts
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- 4. Keymaps (The essentials)
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
		vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Quit Debugger" })

		-- Bonus: Test Method Debugging (requires python treesitter)
		vim.keymap.set("n", "<leader>dm", dap_python.test_method, { desc = "Debug Method" })
	end,
}
