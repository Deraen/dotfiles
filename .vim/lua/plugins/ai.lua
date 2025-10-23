return {
  {
    -- Make sure to set this up properly if you have lazy=true
    'MeanderingProgrammer/render-markdown.nvim',
    ft = {
      "markdown",
      "Avante", "codecompanion"
    },
    opts = {
      file_types = { "markdown", "Avante", "codecompanion" },
      render_modes = { 'n', 'c', 't' },
      bullet = {
        icons = { '●', '○', '◆', '◇' },
        right_pad = 1
      }
    }
  },

  {
    "yetone/avante.nvim",
    enabled = true,

    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      -- for example
      provider = "claude",
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4-20250514",
          timeout = 30000,
          extra_request_body = {
            temperature = 0,
            max_tokens = 2048,
          }
        },
      },
      disabled_tools = {
        "list_files",    -- Built-in file operations
        "search_files",
        "read_file",
        "create_file",
        "rename_file",
        "delete_file",
        "create_dir",
        "rename_dir",
        "delete_dir",
        "bash",         -- Built-in terminal access
      }
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      -- "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
      -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
      -- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      -- "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    enabled = false,

    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function ()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "anthropic",
          },
          inline = {
            adapter = "anthropic",
          },
        },
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              -- MCP Tools
              make_tools = true,              -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
              show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
              add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
              show_result_in_chat = true,      -- Show tool results directly in chat buffer
              format_tool = nil,               -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
              -- MCP Resources
              make_vars = true,                -- Convert MCP resources to #variables for prompts
              -- MCP Prompts
              make_slash_commands = true,      -- Add MCP prompts as /slash commands
            }
          }
        }
      })
    end
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "cd ~/.local && npm install mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup({
        extensions = {
          -- avante = {
          --   make_slash_commands = true,
          -- }
        },
        auto_approve = function(params)
          -- Auto-approve GitHub issue reading
          -- if params.server_name == "github" and params.tool_name == "get_issue" then
          --   return true -- Auto approve
          -- end

          -- Block access to private repos
          if params.arguments.repo == "private" then
            return "You can't access my private repo" -- Error message
          end

          -- Auto-approve safe file operations in current project
          if params.tool_name == "read_file" then
            local path = params.arguments.path or ""
            if path:match("^" .. vim.fn.getcwd()) then
              return true -- Auto approve
            end
          end

          if params.server_name == "clojure_mcp" and
            (params.tool_name == "grep" or params.tool_name == "") then
            return true
          end

          -- Check if tool is configured for auto-approval in servers.json
          if params.is_auto_approved_in_server then
            return true -- Respect servers.json configuration
          end

          return false -- Show confirmation prompt
        end,
      })

      require("avante").setup({
        -- system_prompt as function ensures LLM always has latest MCP server state
        -- This is evaluated for every message, even in existing chats
        system_prompt = function()
          local hub = require("mcphub").get_hub_instance()
          return hub and hub:get_active_servers_prompt() or ""
        end,
        -- Using function prevents requiring mcphub before it's loaded
        custom_tools = function()
          return {
            require("mcphub.extensions.avante").mcp_tool(),
          }
        end,
      })
    end
  }
  -- https://ravitemer.github.io/mcphub.nvim/extensions/codecompanion.html
  -- https://ravitemer.github.io/mcphub.nvim/extensions/copilotchat.html
}
