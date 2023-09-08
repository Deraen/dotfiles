local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  if opts.remap and not vim.g.vscode then
    opts.remap = nil
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map('n', '<M-q>', '<C-w>c', {desc = 'Close window'})
-- map('i', '<M-q>', '<Esc><C-w>c:echo ""<cr>', {desc = 'Close window'})

map('n', '<M-n>', '<C-w>v', {desc = 'New window (vertical split)'})
map('n', '<M-m>', '<C-w>s', {desc = 'New window (horizontal split)'})

map('n', '§', 'qqqqq', {desc = 'Start new macro (q)'})
map({'n', 'n'}, '½', '@q', {desc = 'Run macro (q)'})

map('n', 'ä', ':w<cr>', {desc = 'Save file'})

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

map('t', '<esc>', '<C-\\><C-n>')

map('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })
