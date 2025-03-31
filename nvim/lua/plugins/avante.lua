return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    enabled = true,
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
        provider = "claude",
        auto_suggestions_provider = "claude",
        cursor_planning_provider = "claude",
        behaviour = {
            enable_cursor_planning_mode = false,
            auto_apply_diff_after_generation = true,
            enable_claude_text_editor_tool_mode = true,
            use_cwd_as_project_root = true,
        },
        claude = {
            model = "claude-3-5-sonnet-20241022",
            api_key_name = "cmd:op read op://Private/Anthropic/apikey",
            max_tokens = 8192
        },
        ollama = {
            endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
            model = "codegemma",
        },
        vendors = {
            lmstudio = {
                __inherited_from = 'openai',
                endpoint = 'http://localhost:1234/v1',
                model = 'qwen2.5-coder-14b-instruct',
                api_key = 'NOT NEEDED', -- Add your API key here
            }
        },
        rag_service = {
            enabled = false,     -- Enables the RAG service
            provider = "ollama", -- The provider to use for RAG service (e.g. openai or ollama)
            endpoint = "http://localhost:11434",
            host_mount = vim.fn.expand("~/code")
        },
    },
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
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
