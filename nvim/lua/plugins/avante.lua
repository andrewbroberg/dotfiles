return {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = function()
    -- conditionally use the correct build system for the current OS
    if vim.fn.has("win32") == 1 then
      return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    else
      return "make"
    end
  end,
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- add any opts here
    -- for example
    provider = "claude",
    auto_suggestions_provider = "copilot",
    selector = {
      --- @alias avante.SelectorProvider "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope" | fun(selector: avante.ui.Selector): nil
      --- @type avante.SelectorProvider
      provider = "snacks",
      -- Options override for custom providers
      provider_opts = {},
    },
    input = {
      provider = "snacks",
      provider_opts = {
        -- Additional snacks.input options
        title = "Avante Input",
        icon = " ",
      },
    },
    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-latest",
        api_key_name = "cmd:op read op://Private/Anthropic/apikey",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 8192,
        },
      },
    },
    web_search_engine = {
      provider = "tavily", -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
    },
    rag_service = {
      enabled = true,
      llm = { -- Configuration for the Language Model (LLM) used by the RAG service
        provider = "ollama", -- The LLM provider ("ollama")
        endpoint = "http://host.docker.internal:11434", -- The LLM API endpoint for Ollama
        api_key = "", -- Ollama typically does not require an API key
        model = "llama3", -- The LLM model name (e.g., "llama2", "mistral")
        extra = nil, -- Extra configuration options for the LLM (optional) Kristin", -- Extra configuration options for the LLM (optional)
      },
      host_mount = vim.fn.expand("~/code"),
      embed = { -- Configuration for the Embedding Model used by the RAG service
        provider = "ollama", -- The Embedding provider ("ollama")
        endpoint = "http://host.docker.internal:11434", -- The Embedding API endpoint for Ollama
        api_key = "", -- Ollama typically does not require an API key
        model = "nomic-embed-text", -- The Embedding model name (e.g., "nomic-embed-text")
        extra = { -- Extra configuration options for the Embedding model (optional)
          embed_batch_size = 10
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "stevearc/dressing.nvim", -- for input provider dressing
    "zbirenbaum/copilot.lua", -- for providers='copilot'
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
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
