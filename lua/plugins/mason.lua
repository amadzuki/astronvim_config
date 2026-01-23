-- WARN: Mason configuration is now active

-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",
        "typescript-language-server",
        "basedpyright", -- Python LSP (faster than pyright)

        -- install formatters
        "stylua",
        "texlab",
        "black", -- Python formatter
        "isort", -- Python import sorter

        -- install linters
        "pylint", -- Python linter

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
