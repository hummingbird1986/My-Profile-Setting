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
--------------------------telescope--------------------------
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      -- 设置快捷键 (以空格为空缀键)
--      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
--      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>ff', function()        -- ← 改这行
   	 builtin.find_files({ hidden = true })
    end, {})
    vim.keymap.set('n', '<leader>fg', function()        -- ← 改这行
    	builtin.live_grep({ additional_args = { "--hidden" } })
    end, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end
  },
------------------------------nvim-tree--------------------------------
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

    local function open_nvim_tree()
	    if vim.fn.argc() == 0 then
		    require("nvim-tree.api").tree.open()
	    end
    end
    vim.api.nvim_create_autocmd("VimEnter",{
	    callback=open_nvim_tree,
    })

    vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle File Tree' })
    vim.keymap.set('n', '<leader>f', ':NvimTreeFocus<CR>', { desc = 'Focus File Tree' })
  end,
},
--------------------------------lualine-----------------------
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


-----------------Catppuccin 配置 ---------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- 确保是 mocha
        transparent_background = true,
        term_colors = true,
        integrations = {
          treesitter = true,
          native_lsp = { enabled = true },
          telescope = { enabled = true },
          nvimtree = true,
        },
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },
-------------------------------transparent-----------------------
--{
--  "xiyaowong/transparent.nvim",
--  lazy = false, -- 必须是 false
--  priority = 1000, -- 提升优先级，确保它在主题加载后生效
--  config = function()
--    require("transparent").setup({
--      extra_groups = {
--        "NvimTreeNormal",
--        "NvimTreeNormalNC",
--        "NvimTreeEndOfBuffer",
--        "NvimTreeWinSeparator",
--        "NormalFloat",
--      },
--    })
--    -- 自动执行一次开启命令
--    vim.cmd("TransparentEnable")
--  end,
--},

---------------------------- 1. LSP 管理器 (Mason)
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "lua_ls", "ts_ls" } -- 自动安装你需要的语言服务器
      })
    end,
  },

  ------------------------------ 2. 核心 LSP 配置 (lspconfig)
  {
    "neovim/nvim-lspconfig",
    config = function()
      --local lspconfig = require('lspconfig')
      --local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- 配置具体的语言服务器
      --lspconfig.pyright.setup({ capabilities = capabilities })
      --lspconfig.lua_ls.setup({ capabilities = capabilities })
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.config('pyright', { capabilities = capabilities })
      vim.lsp.config('lua_ls', { capabilities = capabilities })
      vim.lsp.enable({ 'pyright', 'lua_ls' })
    end,
  },

  --------------------------------- 3. 自动补全引擎 (nvim-cmp)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- 让 cmp 支持 lsp 来源
      "hrsh7th/cmp-buffer",   -- 让 cmp 支持当前文件内容
      "L3MON4D3/LuaSnip",     -- 代码片段支持
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args) require('luasnip').lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- 回车确认补全
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
        })
      })
    end,
  },
---------------------------- 'akinsho/toggleterm.nvim'--------------------------
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
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse ="a"
vim.opt.mousemodel="popup"
--vim.keymap.set({'n', 'v', 'i'}, '<MiddleMouse>', '<Nop>')
--vim.keymap.set({'n', 'v', 'i'}, '<2-MiddleMouse>', '<Nop>')
--vim.keymap.set({'n', 'v', 'i'}, '<3-MiddleMouse>', '<Nop>')
--vim.keymap.set({'n', 'v', 'i'}, '<4-MiddleMouse>', '<Nop>')

