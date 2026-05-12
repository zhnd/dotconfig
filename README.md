# dotconfig

我的 dotfiles，使用 [chezmoi](https://www.chezmoi.io/) 管理，支持跨机器（work / personal）配置差异和 [Bitwarden](https://bitwarden.com/) secrets 集成。

## 包含

| 文件 | 用途 |
|---|---|
| `dot_zshrc` | zsh 配置（zinit + fzf + history + setopts） |
| `dot_gitconfig.tmpl` | git 配置（user 字段按机器渲染） |
| `dot_config/ghostty/config` | Ghostty 终端 |
| `dot_config/zellij/config.kdl` | Zellij 多路复用 |
| `dot_config/starship.toml` | Starship 提示符 |

## 新机器开荒

```sh
# 1. 装 chezmoi
brew install chezmoi

# 2. 初始化并应用
chezmoi init --apply https://github.com/zhnd/dotconfig.git
```

首次会提示填写：

- `profile`：`work` 或 `personal`
- `git.name`：git user.name
- `git.email`：git user.email（留空则不设置全局）

填写结果存进 `~/.config/chezmoi/chezmoi.toml`，之后不再询问。

## 日常工作流

```sh
# 编辑配置（直接改 ~ 下文件即可 —— chezmoi add 同步到仓库）
vim ~/.zshrc
chezmoi add ~/.zshrc       # 把改动同步回 source

# 或者反过来：编辑 source 然后应用到 ~
chezmoi edit ~/.zshrc      # 用 $EDITOR 编辑 source 文件
chezmoi apply              # 部署到 ~

# 查看差异
chezmoi diff               # 仓库 → ~ 的差异
chezmoi status             # 摘要

# 推送
chezmoi cd                 # 进入 source 目录
git add . && git commit && git push
exit
```

## 模板变量

在 `*.tmpl` 文件里可以用：

| 变量 | 来源 | 值 |
|---|---|---|
| `{{ .profile }}` | 首次 init 选择 | `"work"` / `"personal"` |
| `{{ .git.name }}` | 首次 init 输入 | git user.name |
| `{{ .git.email }}` | 首次 init 输入 | git user.email（可空） |
| `{{ .chezmoi.os }}` | 内置 | `"darwin"` / `"linux"` |
| `{{ .chezmoi.hostname }}` | 内置 | 主机名 |

例：只在工作机加载某段配置

```
{{ if eq .profile "work" }}
# work 专属
{{ end }}
```

## Bitwarden secrets

需要 `bw` CLI 已登录并 unlock：

```sh
brew install bitwarden-cli
bw login
export BW_SESSION=$(bw unlock --raw)
```

之后模板里可以：

```
{{ (bitwardenFields "item" "GitHub Token").token.value }}
```

`chezmoi apply` 时自动从 Bitwarden 拉取。
