return {
    "nvim-treesitter/nvim-treesitter",
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

        require("nvim-treesitter").install(parsers)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "lua", "vim", "markdown", "c",
                "go", "gomod", "gowork", "rust",
                "javascript", "javascriptreact",
                "typescript", "typescriptreact",
                "jsdoc",
                "proto",
            },
            callback = function()
                vim.treesitter.start()
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
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
