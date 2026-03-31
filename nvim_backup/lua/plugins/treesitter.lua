-- https://github.com/fredrikaverpil/dotfiles

local function sign_parser_macos(parser_name)
    if vim.fn.has("mac") ~= 1 then
        return
    end
    local parser_path = vim.fn.stdpath("data") .. "/site/parser/" .. parser_name .. ".so"
    if vim.fn.filereadable(parser_path) == 1 then
        vim.fn.system({ "codesign", "--force", "--sign", "-", parser_path })
    end
end

local function install_and_start()
    vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
        callback = function(event)
            local bufnr = event.buf
            local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

            if filetype == "" then
                return
            end

            local parser_name = vim.treesitter.language.get_lang(filetype) -- WARNING: might return filetype (not helpful)
            if not parser_name then
                return
            end
            local parser_configs = require("nvim-treesitter.parsers")
            local parser_can_be_used = parser_configs[parser_name]
            if not parser_can_be_used then
                return
            end

            local parser_installed = vim.treesitter.get_parser(bufnr, parser_name) ~= nil

            if not parser_installed then
                require("nvim-treesitter").install({ parser_name }):wait(30000)
                sign_parser_macos(parser_name)
            end

            parser_installed = vim.treesitter.get_parser(bufnr, parser_name) ~= nil
            if not parser_installed then
                vim.notify(
                    "Failed to get parser for " .. parser_name .. " after installation",
                    vim.log.levels.WARN,
                    { title = "core/treesitter" }
                )
                return
            end

            vim.treesitter.start(bufnr, parser_name)
        end,
    })
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = true,
        event = "BufRead",
        branch = "main",
        build = ":TSUpdate",
        config = function(_, opts)
            install_and_start()
        end,
    },
}
