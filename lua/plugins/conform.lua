---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = function(_, opts)
    opts.formatters_by_ft = {
      -- javascript = { "biome" },
      -- typescript = { "biome" },
      -- json = { "biome" },
      lua = { "stylua" },
      python = { "isort", "black" },
    }
    opts.format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    }
    return opts
  end,
}
