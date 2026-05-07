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
{
  "xiyaowong/transparent.nvim",
  lazy = false, -- 必须是 false
  priority = 1000, -- 提升优先级，确保它在主题加载后生效
  config = function()
    require("transparent").setup({
      extra_groups = {
        "NvimTreeNormal",
        "NvimTreeNormalNC",
        "NvimTreeEndOfBuffer",
        "NvimTreeWinSeparator",
        "NormalFloat",
      },
    })
    -- 自动执行一次开启命令
    vim.cmd("TransparentEnable")
  end,
},

 }) 
vim.opt.number = true
vim.opt.relativenumber = true

