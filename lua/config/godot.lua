-- Setup in Godot:
--
-- Settings > General > Text Editor > External
-- Exec Path:            nvim
-- Exec Flags:           --server /tmp/godot.pipe --remote-send "<esc>:n {file}<CR>:call cursor({line},{col})<CR>"
-- Use External Editor:  On
--
-- Additionally:
-- Settings > General > Text Editor > Behavior
-- Auto Reload Scripts on External Change: On


-- pipe that Godot can send commands to for NeoVim to pick up
local pipe = "/tmp/godot.pipe"

local function start_godot_server()
    local root_dir = vim.fs.root(".", { "project.godot" })
    if root_dir == nil then return end

    -- check if already running
    local stat = vim.uv.fs_stat(pipe)
    if stat then return end

    vim.fn.serverstart(pipe)
end

start_godot_server()
