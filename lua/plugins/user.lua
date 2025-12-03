-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            " █████  ███████ ████████ ██████   ██████ ",
            "██   ██ ██         ██    ██   ██ ██    ██",
            "███████ ███████    ██    ██████  ██    ██",
            "██   ██      ██    ██    ██   ██ ██    ██",
            "██   ██ ███████    ██    ██   ██  ██████ ",
            "",
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },
  },

  -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      opts.sources = {} -- Clear all sources
      return opts
    end,
  },

  -- Text wrapping configuration for markdown and other text files
  {
    "AstroNvim/astrocore",
    opts = {
      options = {
        opt = {
          -- Global wrap settings
          wrap = true,           -- Enable line wrapping
          linebreak = true,      -- Wrap at word boundaries
          breakindent = true,    -- Preserve indentation in wrapped lines
          showbreak = "↪ ",      -- Character to show at the beginning of wrapped lines
        },
      },
      autocommands = {
        -- Set up text wrapping for specific file types
        {
          event = { "FileType" },
          pattern = { "markdown", "text", "gitcommit", "txt" },
          callback = function()
            vim.opt_local.wrap = true
            vim.opt_local.linebreak = true
            vim.opt_local.breakindent = true
            vim.opt_local.showbreak = "↪ "
          end,
        },
        -- For code files, keep wrap disabled but enable it temporarily
        {
          event = { "FileType" },
          pattern = { "lua", "python", "javascript", "typescript", "json", "yaml" },
          callback = function()
            vim.opt_local.wrap = false
          end,
        },
      },
      -- Custom keymaps for wrap navigation
      mappings = {
        n = {
          -- Move between wrapped lines
          ["j"] = { "gj", desc = "Move down (respect wrap)" },
          ["k"] = { "gk", desc = "Move up (respect wrap)" },
          ["<Down>"] = { "gj", desc = "Move down (respect wrap)" },
          ["<Up>"] = { "gk", desc = "Move up (respect wrap)" },
          -- Toggle wrap
          ["<leader>tw"] = {
            function()
              vim.opt.wrap = not vim.opt.wrap:get()
              print("Wrap " .. (vim.opt.wrap:get() and "enabled" or "disabled"))
            end,
            desc = "Toggle line wrap"
          },
          ["<leader>xc"] = {
            function() vim.fn.setqflist({}) end,
            desc = "Clear quickfix list"
          },
        },
      },
    },
  },
}
