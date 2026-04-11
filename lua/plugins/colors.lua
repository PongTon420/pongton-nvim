return {
        {
                "folke/tokyonight.nvim",
                lazy = false,
                priority = 1000,
                opts = {
                        transparent = true,
                },
                styles = {
                        sidebars = "transparent",
                        floats = "transparent",
                },
                config = function(_, opts)
                        require("tokyonight").setup(opts)
                        vim.cmd.colorscheme("tokyonight-night")
                        vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#9f33a1', bold=true })
                        vim.api.nvim_set_hl(0, 'CursorLineNr', { fg='#fb9ef7', bold=true })
                        vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#9f33a1', bold=true })
                end
        },
        {
                "nvim-lualine/lualine.nvim",
                dependencies = {
                        "nvim-tree/nvim-web-devicons",
                },
                opts = {
                        theme = 'tokyonight',
                },
        },
}
