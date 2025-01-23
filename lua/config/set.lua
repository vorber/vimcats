vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

if os.getenv('WAYLAND_DISPLAY') and vim.fn.exepath('wl-copy') ~= "" then
  vim.g.clipboard = {
      name = 'wl-clipboard',
      copy = {
          ['+'] = 'wl-copy',
          ['*'] = 'wl-copy',
      },
      paste = {
          ['+'] = 'wl-paste',
          ['*'] = 'wl-paste',
      },
      cache_enabled = 1,
  }
end

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

--vim.opt.guicursor = ""
vim.opt.cursorline = true

--vim.opt.nu = true
vim.wo.number = true
vim.wo.relativenumber = true

vim.o.smarttab = true
vim.opt.cpoptions:append('I')
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.breakindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = (os.getenv("HOME") or os.getenv("USERPROFILE")) .. "/.vim/undodir"
vim.o.undofile = true

vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.opt.incsearch = true
vim.opt.inccommand = 'split'
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.completeopt = 'menu,preview,noselect'

vim.o.termguicolors = true

vim.opt.scrolloff = 8
vim.wo.signcolumn = "yes"

vim.opt.updatetime = 50
vim.opt.colorcolumn = "120"

-- [[ Disable auto comment on enter ]]
-- See :help formatoptions
vim.api.nvim_create_autocmd("FileType", {
  desc = "remove formatoptions",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.g.netrw_liststyle=0
vim.g.netrw_banner=0

vim.opt.exrc = true



