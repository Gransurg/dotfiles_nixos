return {
  'mrcjkb/rustaceanvim',
  version = '^9',
  lazy = false, -- Плагин должен загружаться при старте, чтобы зарегистрировать команды
  config = function()
    vim.g.rustaceanvim = {
      -- Настройки для сервера
      server = {
        on_attach = function(client, bufnr)
          -- Привязываем клавишу K для показа документации
          vim.keymap.set("n", "K", function()
            vim.cmd.RustLsp({ 'hover', 'actions' })
          end, { buffer = bufnr, desc = "Rust Hover Actions" })

          -- Если хочешь, чтобы работал запуск по клавише (например, <leader>r)
          -- vim.keymap.set("n", "<leader>r", function()
          --   vim.cmd.RustLsp('run')
          -- end, { buffer = bufnr, desc = "Rust Run" })
        end,
      },
    }
  end,
}
