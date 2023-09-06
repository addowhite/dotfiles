require "paq" {
    "savq/paq-nvim", -- Let Paq manage itself
    "ilyachur/cmake4vim",
    "neovim/nvim-lspconfig",
    "junegunn/fzf.vim",
    "catppuccin/nvim"
}

local set = vim.opt
local indent_width = 2
set.tabstop = indent_width
set.softtabstop = indent_width
set.shiftwidth = indent_width
set.expandtab = true
set.foldmethod = "indent"
set.foldenable = false
set.number = true
set.relativenumber = true

vim.cmd.colorscheme("lunaperche")
--vim.cmd.colorscheme("catppuccin-mocha")
--vim.cmd.colorscheme("darkblue")

vim.g.mapleader = '<space>'

local bufopts = { noremap=true, silent=true, buffer=bufnr }
vim.keymap.set("i", "jj", "<escape>", bufopts)
vim.keymap.set("n", "<F5>", ":w | terminal ./build.sh<enter>A", bufopts)
vim.keymap.set("n", "<F6>", ":w | !sublime_merge .<enter><enter>", bufopts)
--vim.keymap.set("n", "<F5>", ":w | !./build.sh<enter>", bufopts)
vim.keymap.set("n", "<C-p>", ":Files<enter>", bufopts)
vim.keymap.set("n", "<C-f>", ":Rg<enter>", bufopts)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', '<C-[>', ":cprevious<enter>", bufopts)
vim.keymap.set('n', '<C-]>', ":cnext<enter>", bufopts)

vim.g.cmake_kits = {
    ninja = {
        generator = "Ninja"
    }
}
vim.g.cmake_selected_kit = "ninja"
vim.g.cmake_build_type = "Debug"

require'lspconfig'.clangd.setup{}
