return {
    "saghen/blink.cmp",
    version = "1.0",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    enabled = function()
        return not vim.tbl_contains({ "lua", "markdown" }, vim.bo.filetype)
            and vim.bo.buftype ~= "prompt"
            and vim.b.completion ~= false
    end,
    opts = {
        completion = {
            keyword = { range = 'full' },
            trigger = { show_on_trigger_character = true },

            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },

            menu = {
                draw = {
                    columns = { { 'label', 'label_description', 'kind',  gap = 1 }, }
                },
            },

            list = { selection = { preselect = function(ctx) return ctx.mode ~= 'cmdline' end } },
        },
        keymap = {
            preset = "default",
            ["<C-p>"] = {},
            ["<C-n>"] = {},
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono"
        },

        sources = {
            default = { "lazydev", "path", "lsp", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
            -- disable cmdline completions
        },
        cmdline = { sources = {} }
    },
    opts_extend = { "sources.default" }
}
