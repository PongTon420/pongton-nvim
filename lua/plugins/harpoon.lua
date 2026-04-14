return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
        local harpoon = require("harpoon")
        
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
        })

        -- Basic Harpoon UI & Adding
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Quick Menu" })

        -- Direct Jump Keys (The "Magic" of Harpoon)
        -- Maps <leader>1 through <leader>4 to jump to specific slots
        for i = 1, 4 do
            vim.keymap.set("n", "<leader>" .. i, function() 
                harpoon:list():select(i) 
            end, { desc = "Harpoon: Jump to file " .. i })
        end

        -- Relative Navigation
        vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end)

        -- Telescope Integration
        vim.keymap.set("n", "<leader>fl", function()
            local conf = require("telescope.config").values
            local themes = require("telescope.themes")
            local file_paths = {}
            
            for _, item in ipairs(harpoon:list().items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new(themes.get_ivy({ prompt_title = "Harpoon Hooks" }), {
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end, { desc = "Telescope: Harpoon Window" })
    end
}
