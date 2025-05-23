return {
    "mistweaverco/kulala.nvim",
    dependencies = {
        {
            "bosvik/http-convert.nvim",
            cmd = { "ConvertFromOpenApi", "ConvertFromPostman" },
            opts = {
                formatter_path = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "kulala-fmt"),
            },
        },
    },
    keys = {
        { "<leader>Rs", desc = "Send request" },
        { "<leader>Ra", desc = "Send all requests" },
        { "<leader>Rb", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
        global_keymaps = true,
    },
}
