return {
  "preservim/vim-pencil",
  init = function()
    -- Set configuration options here BEFORE the plugin loads
    vim.g["pencil#wrapModeDefault"] = "soft" -- options: 'soft' or 'hard'
  end,
  config = function()
    -- Optional: Auto-trigger pencil for specific file types
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "text", "mail", "gmi" },
      callback = function()
        vim.cmd("Pencil")
      end,
    })
  end,
}
