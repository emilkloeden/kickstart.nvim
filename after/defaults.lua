vim.opt.relativenumber = true

-- Basic telescope search
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
-- ' ff' for find_files, show hidden
vim.keymap.set('n', '<Leader>ff', ':lua require"telescope.builtin".find_files({ hidden = true })<CR>', {noremap = true, silent = true}) 


-- this section allows us to comment multiple lines using 'Ctrl+/'
local map = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }

local modes = {'n', 'v'} -- normal and visual mode

for i in pairs(modes) do
        map(modes[i], '<C-_>', ':call nerdcommenter#Comment(0, "toggle")<CR>' , opts)
end