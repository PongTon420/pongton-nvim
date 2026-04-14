return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      require("mason").setup({
        ui = { border = "rounded" }
      })

      require("mason-lspconfig").setup({
        ensure_installed = { 
          "lua_ls", 
          "ts_ls", 
          "java_language_server" 
        },
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local servers = { "lua_ls", "ts_ls", "java_language_server" }

      for _, server in ipairs(servers) do
        if vim.lsp.config then
          vim.lsp.config(server, {
            capabilities = capabilities,
            root_dir = vim.fs.root(0, { ".git", "pom.xml", "gradlew", "package.json" }),
          })
        else
          require('lspconfig')[server].setup({ 
            capabilities = capabilities 
          })
        end
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },
}
