local port = tonumber(os.getenv("GDScript_Port")) or 6005
local cmd = vim.lsp.rpc.connect("127.0.0.1", port)

-- Use platform-specific pipe path
local pipe = vim.fn.has("win32") and "\\\\.\\pipe\\godot.pipe" or "/tmp/godot.pipe"

vim.lsp.start({
    name = "Godot",
    cmd = cmd,
    root_dir = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]),
    on_attach = function(client, bufnr)
        vim.api.nvim_command('call serverstart("' .. pipe .. '")')
    end,
})
