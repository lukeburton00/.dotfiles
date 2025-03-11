return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    event = 'VeryLazy',

    config = function ()
        local harpoon = require("harpoon")

        harpoon:setup()

        local normalize_list = function(t)
            local normalized = {}
            for _, v in pairs(t) do
                if v ~= nil then
                    table.insert(normalized, v)
                end
            end
            return normalized
        end

        vim.keymap.set("n", "<leader>e", function()
            require("snacks").picker({
                finder = function()
                    local file_paths = {}
                    local list = normalize_list(harpoon:list().items)
                    for _, item in ipairs(list) do
                        table.insert(file_paths, { text = item.value, file = item.value })
                    end
                    return file_paths
                end,
                win = {
                    input = {
                        keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
                    },
                    list = {
                        keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
                    },
                },
                actions = {
                    harpoon_delete = function(picker, item)
                        local to_remove = item or picker:selected()
                        harpoon:list():remove({ value = to_remove.text })
                        harpoon:list().items = normalize_list(harpoon:list().items)
                        picker:find({ refresh = true })
                    end,
                },
            })
        end)

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)

        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

        vim.keymap.set("n", "<leader>p", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<leader>n", function() harpoon:list():next() end)
    end
}
