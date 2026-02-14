-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ファイルパスをクリップボードにコピー
vim.keymap.set("n", "<leader>yp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Copy absolute file path" })

vim.keymap.set("n", "<leader>yr", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Copy relative file path" })

-- ファイルを手動でリロード
vim.keymap.set("n", "<leader>r", ":checktime<CR>", { desc = "Reload file from disk" })
