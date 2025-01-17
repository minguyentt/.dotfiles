return {
    "saghen/blink.cmp",
    version = "*",
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
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },
            menu = {
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind_icon", "kind" },
                    },
                },
            },
            list = { selection = { preselect = function(ctx) return ctx.mode ~= 'cmdline' end} },
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
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
            -- disable cmdline completions
            cmdline = {},
        },
        signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
}
