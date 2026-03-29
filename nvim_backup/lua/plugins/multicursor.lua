return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    lazy = true,
    keys = {
        {
            "<up>",
            function()
                require("multicursor-nvim").lineAddCursor(-1)
            end,
            desc = "Add Cursor Up",
            mode = { "n", "x" },
        },
        {
            "<down>",
            function()
                require("multicursor-nvim").lineAddCursor(1)
            end,
            desc = "Add Cursor Down",
            mode = { "n", "x" },
        },
        {
            "<c-leftmouse>",
            function()
                require("multicursor-nvim").handleMouse()
            end,
            desc = "Add Cursor Mouse",
            mode = "n",
        },
        {
            "<c-leftdrag>",
            function()
                require("multicursor-nvim").handleMouseDrag()
            end,
            desc = "Add Cursor Mouse Drag",
            mode = "n",
        },
        {
            "<c-leftrelease>",
            function()
                require("multicursor-nvim").handleMouseRelease()
            end,
            desc = "Add Cursor Mouse Release",
            mode = "n",
        },
        {
            "<leader>n",
            function()
                require("multicursor-nvim").matchAddCursor(1)
            end,
            desc = "Add Cursor Next Match",
            mode = { "n", "x" },
        },
        {
            "<leader>N",
            function()
                require("multicursor-nvim").matchAddCursor(-1)
            end,
            desc = "Add Cursor Previous Match",
            mode = { "n", "x" },
        },
        {
            "<leader>s",
            function()
                require("multicursor-nvim").matchSkipCursor()
            end,
            desc = "Skip Cursor Next Match",
            mode = { "n", "x" },
        },
        {
            "<leader>S",
            function()
                require("multicursor-nvim").matchSkipCursor(-1)
            end,
            desc = "Skip Cursor Previous Match",
            mode = { "n", "x" },
        },
        {
            "<left>",
            function()
                require("multicursor-nvim").prevCursor()
            end,
            desc = "Previous Cursor",
            mode = "n",
        },
        {
            "<right>",
            function()
                require("multicursor-nvim").nextCursor()
            end,
            desc = "Next Cursor",
            mode = "n",
        },
        {
            "<leader>x",
            function()
                require("multicursor-nvim").deleteCursor()
            end,
            desc = "Delete Cursor",
            mode = "n",
        },
    },
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()
        mc.addKeymapLayer(function(layerSet)
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { reverse = true })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn" })
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { reverse = true })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
}
