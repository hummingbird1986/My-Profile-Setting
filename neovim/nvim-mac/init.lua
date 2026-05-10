local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

-----------------------------nvim-telescope-------------------------------
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      -- 设置快捷键 (以空格为空缀键)
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end
  },
---------------------------nvim-tree---------------------------------------
{
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false, -- 建议不懒加载，以便启动后能快速打开
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- 可选：用于显示漂亮的文件图标
  },
  config = function()
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 30,
        relativenumber = true, -- 显示相对行号，方便跳转
      },
      renderer = {
        group_empty = true, -- 合并空目录
      },
      filters = {
        dotfiles = false, -- 是否隐藏点文件
      },
    })

    vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle File Tree' })
    vim.keymap.set('n', '<leader>f', ':NvimTreeFocus<CR>', { desc = 'Focus File Tree' })
  end,
},
---------------------------nvim-lualine---------------------------------------
  {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'dracula', -- 或者 tokyonight, catppuccin
      icons_enabled = true,
    }
  }
},
------------------------catppuccin/nvim------------------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- 确保它最先加载
    config = function()
      require("catppuccin").setup({
        transparent_background = true, -- 顺便开启你想要的透明效果
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },

-----------------------------akinsho/toggleterm.nvim------------------------------
{
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]], -- 快捷键切换
      direction = 'float',      -- 浮窗模式
    })
  end
}
}) 

-- 显示绝对行号
vim.opt.number = true

-- 强烈建议开启：相对行号（对 Vim 快捷键操作非常有帮助）
vim.opt.relativenumber = true
