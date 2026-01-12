-- WARN: This file is now active

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
            "███   ██ ██   ██ ████   ███",
            "████  ██ ██   ██ ██████ ████",
            "██ ██ ██ ██   ██ ██ ██████ ██",
            "██  ██ ██  ██  ██ ██  ██  ██",
            "██   ███   ███   ██ ██     ██",
          }, "\n"),
        },
      },
      -- Configure picker to search from current directory by default
      picker = vim.tbl_deep_extend("force", {
        -- Use current directory for file searches
        files = {
          dirs = { vim.fn.getcwd() },
        },
        -- Use current directory for grep searches
        grep = {
          dirs = { vim.fn.getcwd() },
        },
      }, {}),
    },
  },

  -- Neo-tree configuration to use current directory
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        -- Use the current directory where nvim was opened
        rootizers = {
          -- Only use explicit project markers, not parent directories
          ".git",
          "package.json",
          "tsconfig.json",
          "jsconfig.json",
          ".gitignore",
        },
        -- Don't scan parent directories
        scan_mode = "shallow",
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

      -- add custom snippet
      luasnip.config(vim.tbl_deep_extend("force", opts, {
        paths = { vim.fn.stdpath "config" .. "/snippets" },
      }))
      require("luasnip.loaders.from_vscode").lazy_load()
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

  -- AstroCore configuration with all settings
  {
    "AstroNvim/astrocore",
    opts = {
      rooter = {
        autochdir = true,
        -- Use the current directory as fallback when no project markers are found
        -- This prevents it from going up to home directory
        fallback = vim.fn.getcwd,
      },
      options = {
        opt = {
          -- Global wrap settings
          wrap = true, -- Enable line wrapping
          linebreak = true, -- Wrap at word boundaries
          breakindent = true, -- Preserve indentation in wrapped lines
          showbreak = "↪ ", -- Character to show at the beginning of wrapped lines
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
            -- Disable concealing for JSON to show quotes
            if vim.bo.filetype == "json" then
              vim.opt_local.conceallevel = 0
            end
          end,
        },
      },
      -- Custom keymaps
      mappings = {
        n = {
          -- Move between wrapped lines
          ["j"] = { "gj", desc = "Move down (respect wrap)", expr = false },
          ["k"] = { "gk", desc = "Move up (respect wrap)", expr = false },
          ["<Down>"] = { "gj", desc = "Move down (respect wrap)", expr = false },
          ["<Up>"] = { "gk", desc = "Move up (respect wrap)", expr = false },
          -- Toggle wrap
          ["<leader>tw"] = {
            function()
              vim.opt.wrap = not vim.opt.wrap:get()
              print("Wrap " .. (vim.opt.wrap:get() and "enabled" or "disabled"))
            end,
            desc = "Toggle line wrap",
          },
          ["<leader>xc"] = {
            function() vim.fn.setqflist {} end,
            desc = "Clear quickfix list",
          },
          -- Language tools
          ["<leader>lF"] = {
            function()
              -- Try LSP code action first (source.fixAll.biome)
              local bufnr = vim.api.nvim_get_current_buf()
              local clients = vim.lsp.get_active_clients { bufnr = bufnr }
              local biome_found = false

              for _, client in ipairs(clients) do
                if client.name == "biome" then
                  biome_found = true
                  -- Request code action with source.fixAll
                  local params = vim.lsp.util.make_range_params()
                  params.context = {
                    only = { "source.fixAll" },
                    diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
                  }

                  client.request("textDocument/codeAction", params, function(err, result)
                    if err or not result then
                      -- Fall back to CLI if LSP fails
                      goto fallback_cli
                    end

                    for _, action in ipairs(result) do
                      if action.kind == "source.fixAll" then
                        vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
                        vim.notify("Biome fixAll applied via LSP", vim.log.levels.INFO)
                        -- Reload buffer to show changes
                        vim.cmd "edit"
                        return
                      end
                    end

                    ::fallback_cli::
                    -- Fallback to biome CLI
                    local has_biome = vim.fn.executable "biome" == 1
                    if has_biome then
                      local filepath = vim.fn.expand "%:p"
                      local cmd = { "bunx", "--bun", "biome", "lint", "--write", filepath }
                      vim.fn.jobstart(cmd, {
                        on_exit = function(_, code, _)
                          if code == 0 then
                            vim.notify("Biome lint fixes applied via CLI", vim.log.levels.INFO)
                            -- Reload buffer to show changes
                            vim.cmd "checktime"
                          else
                            vim.notify("Biome lint fixes failed", vim.log.levels.ERROR)
                          end
                        end,
                      })
                    else
                      vim.notify("Biome not found. Please install Biome or ensure it's in PATH", vim.log.levels.WARN)
                    end
                  end, bufnr)
                  break
                end
              end

              if not biome_found then
                -- Direct CLI call if no biome LSP client
                local has_biome = vim.fn.executable "biome" == 1
                if has_biome then
                  local filepath = vim.fn.expand "%:p"
                  local cmd = { "bunx", "--bun", "biome", "lint", "--write", filepath }
                  vim.fn.jobstart(cmd, {
                    on_exit = function(_, code, _)
                      if code == 0 then
                        vim.notify("Biome lint fixes applied via CLI", vim.log.levels.INFO)
                        -- Reload buffer to show changes
                        vim.cmd "checktime"
                      else
                        vim.notify("Biome lint fixes failed", vim.log.levels.ERROR)
                      end
                    end,
                  })
                else
                  vim.notify("Biome not found. Please install Biome or ensure it's in PATH", vim.log.levels.WARN)
                end
              end
            end,
            desc = "Apply safe linting fixes (Biome)",
          },
        },
        i = {
          -- Ctrl+, to trigger completion (alternative to Ctrl+Space)
          ["<C-,>"] = {
            function() require("blink.cmp").show() end,
            desc = "Trigger completion menu",
          },
        },
      },
    },
  },
  {
    "Equilibris/nx.nvim",

    dependencies = {
      "nvim-telescope/telescope.nvim",
    },

    opts = {
      -- See below for config options
    },

    -- Plugin will load when you use these keys
    keys = {
      { "<leader>nx", "<cmd>Telescope nx actions<CR>", desc = "nx actions" },
    },
  },
}
