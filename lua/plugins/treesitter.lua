-- WARN: Treesitter configuration is now active

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "html",
      "javascript",
      "typescript",
      "tsx",
      "jsx",
      "json",
      -- add more arguments for adding more treesitter parsers
    },
  },
}
