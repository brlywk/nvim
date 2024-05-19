--- @diagnostic disable: missing-fields
----- setup -----
local dap = require "dap"
local dap_ui = require "dapui"

-- mason-dap integration
require("mason-nvim-dap").setup {
    automatic_setup = true,
    -- always install these adapters
    ensure_installed = {
        "delve", -- improved Go debugging
    },
    -- additional handler config
    handlers = {},
}

-- adapter setup
require("dap-go").setup {}

-- ui setup
dap_ui.setup {}

----- keymaps -----

local set = vim.keymap.set
local opts = { silent = true }

-- general keymaps
opts.desc = "Toggle breakpoint"
set("n", "<leader>db", dap.toggle_breakpoint, opts)

opts.desc = "Conditional breakpoint"
set("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input "Breakpoint condition:")
end, opts)

opts.desc = "Run to cursor"
set("n", "<leader>dc", dap.run_to_cursor, opts)

opts.desc = "Eval under cursor"
set("n", "<leader>dd", function()
    dap_ui.eval(nil, { enter = true })
end, opts)

opts.desc = "Run / Continue"
set("n", "<F1>", dap.continue, opts)
set("n", "<leader>dr", dap.continue, opts)

opts.desc = "Step into"
set("n", "<F2>", dap.step_into, opts)
set("n", "<leader>di", dap.step_into, opts)

opts.desc = "Step over (next)"
set("n", "<F3>", dap.step_over, opts)
set("n", "<leader>dn", dap.step_over, opts)

opts.desc = "Step out"
set("n", "<F4>", dap.step_out, opts)
set("n", "<leader>do", dap.step_out, opts)

opts.desc = "Step back (prev)"
set("n", "<F5>", dap.step_back, opts)
set("n", "<leader>dp", dap.step_back, opts)

opts.desc = "Restart"
set("n", "<F12>", dap.restart, opts)
set("n", "<leader>dR", dap.restart, opts)

----- some more ui setup required -----
dap.listeners.before.attach.dapui_config = dap_ui.open
dap.listeners.before.launch.dapui_config = dap_ui.open
dap.listeners.before.event_terminated.dapui_config = dap_ui.close
dap.listeners.before.event_exited.dapui_config = dap_ui.close
