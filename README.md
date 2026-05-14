# Zsh 插件安装指南

## 安装插件

| # | 插件 | 功能 |
|---|------|------|
| 1 | `zsh-autosuggestions` | 根据历史命令自动补全建议 |
| 2 | `F-Sy-H` | 高性能语法高亮，比 zsh-syntax-highlighting 更快 |
| 3 | `zsh-syntax-highlighting` | 实时语法高亮，输入命令时即时着色 |
| 4 | `zsh-autocomplete` | 实时下拉补全菜单，自动显示候选项 |

```zsh
# 1. zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# 2. fast-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting


# 3. zsh-autocomplete
git clone https://github.com/marlonrichert/zsh-autocomplete \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
```

---

## 启用插件

编辑 `~/.zshrc`，将插件名加入 `plugins` 列表：

```zsh
plugins=(
  git
  tmux
  zsh-autosuggestions
  fast-syntax-highlighting 
  zsh-autocomplete
)
```

完成后重载配置：

```zsh
source ~/.zshrc
```

---

## ⚠️ 注意事项

| 插件 | 说明 |
|------|------|
| `F-Sy-H` | 与 `zsh-syntax-highlighting` 功能重叠，**二选一**即可 |
| `zsh-autocomplete` | 可能与部分主题的 Tab 补全行为冲突，按需启用 |
