return {
        {
                'ojroques/vim-oscyank',
        },
        {
                'tpope/vim-fugitive',
                config = function()
                        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
                end
        },
        {
                'brenoprata10/nvim-highlight-colors',
                config = function()
                        require('nvim-highlight-colors').setup({})
                end
        },
}
