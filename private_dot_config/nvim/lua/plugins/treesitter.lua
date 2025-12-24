return {
    "nvim-treesitter/nvim-treesitter",
    version = "v0.10.0",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local parsers = {
            "lua", "vim", "markdown", "c",
            "go", "gomod", "gowork", "rust",
            -- TS/JS
            "javascript", "typescript", "tsx", "jsdoc",
            -- Proto
            "proto",
        }

        require("nvim-treesitter.configs").setup({
            ensure_installed = parsers,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })

        -- For Neovim versions where Tree-sitter highlighting can be overridden
        -- by semantic tokens, explicitly prefer TS highlight groups for functions
        -- if you like their style more than the default.
        vim.api.nvim_set_hl(0, "@method", { link = "Function", default = false })
        vim.api.nvim_set_hl(0, "@function", { link = "Function", default = false })
        vim.api.nvim_set_hl(0, "@method.call", { link = "Function", default = false })
        vim.api.nvim_set_hl(0, "@function.call", { link = "Function", default = false })
    end,
}
