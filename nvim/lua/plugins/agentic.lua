return {
    "carlos-algms/agentic.nvim",

    opts = {
        provider = os.getenv("AGENTIC_PROVIDER") or "opencode-acp",
    },

    keys = {
        {
            "<C-\\>",
            function()
                require("agentic").toggle()
            end,
            mode = { "n", "v", "i" },
            desc = "Toggle Agentic Chat",
        },
        {
            "<C-a>",
            function()
                require("agentic").add_selection_or_file_to_context()
            end,
            mode = { "n", "v" },
            desc = "Add file or selection to Agentic to Context",
        },
        {
            "<C-,>",
            function()
                require("agentic").new_session()
            end,
            mode = { "n", "v", "i" },
            desc = "New Agentic Session",
        },
    },
}
