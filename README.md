# dotconfig

我的 dotfiles，[chezmoi](https://www.chezmoi.io/) 管理。

- 多机同步（macOS / Fedora），按 profile 区分 **work / personal**
- 新机器一行命令开荒，自动装齐 CLI 工具
- 模板化 `gitconfig`，敏感配置走 [Bitwarden](https://bitwarden.com/)

---

## 包含

| 工具 / 文件 | 部署到 | 内容 |
|---|---|---|
| `dot_zshrc` | `~/.zshrc` | 通用：zinit + fzf + history + setopts + 各种 hook |
| `dot_zshrc.work` | `~/.zshrc.work` | **work 专属**：CNB MR push aliases、Android SDK、Flutter pub-cache、mise activate |
| `dot_gitconfig.tmpl` | `~/.gitconfig` | git 配置（user 字段按机器渲染） |
| `dot_config/ghostty/config` | `~/.config/ghostty/config` | Ghostty 终端 |
| `dot_config/zellij/config.kdl` | `~/.config/zellij/config.kdl` | Zellij 多路复用 |
| `dot_config/starship.toml` | `~/.config/starship.toml` | Starship 提示符 |
| `run_onchange_before_install-packages.sh.tmpl` | _(脚本)_ | 按 OS 自动装齐 CLI 工具，内容变化时自动重跑 |

工具栈（脚本会自动装）：bat / bitwarden-cli / chezmoi / direnv / eza / fd / fzf / gh / git-delta / lazygit / mise / neovim / pnpm / ripgrep / starship / zellij / zoxide，macOS 另装 Ghostty。

---

## 新机器开荒

### macOS

```sh
# 一行：装 chezmoi、clone、首次 init、自动装齐 brew 工具、部署 dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply zhnd
```

### Fedora

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply zhnd
```

> 脚本会用 `dnf` 装官方源里有的、用 `mise.run` 安装器装 mise。zellij / bitwarden-cli 需要手动装（脚本会提示链接）。

### 首次会提示

```
Machine profile: [personal/work]
Git user.name: 
Git user.email (留空则不设置全局): 
```

填写结果存到 `~/.config/chezmoi/chezmoi.toml`，之后不再询问。修改：

```sh
chezmoi edit-config        # 改本机变量
chezmoi apply              # 重新渲染部署
```

---

## 日常工作流

### 改配置（最简洁）

```sh
chezmoi edit ~/.zshrc           # 在 $EDITOR 里打开源文件
chezmoi apply                    # 部署
# 或者一气呵成：
chezmoi edit --apply ~/.zshrc
```

### 改配置（直觉派）

```sh
nvim ~/.zshrc                    # 直接改部署的副本
chezmoi add ~/.zshrc             # 把改动同步回 source
```

### 查看

```sh
chezmoi diff                     # 仓库 → ~ 的待应用差异
chezmoi diff ~/.zshrc            # 只看某个文件
chezmoi cat ~/.zshrc             # 看仓库源（.tmpl 会按本机变量渲染后输出）
chezmoi managed                  # 列出所有纳管文件
chezmoi status                   # 摘要
```

### 推送 / 拉取（跨机器同步）

```sh
chezmoi cd                       # 切到 ~/.local/share/chezmoi（带 git）
git add . && git commit -m "..." && git push
exit

chezmoi update                   # 在另一台机：拉远端并自动 apply
```

---

## 文件命名约定（chezmoi）

| 前缀 / 后缀 | 含义 |
|---|---|
| `dot_xxx` | 部署为 `~/.xxx` |
| `xxx.tmpl` | 模板，渲染后部署 |
| `run_onchange_before_xxx.sh.tmpl` | 内容哈希变化时执行，**在文件部署之前** |
| `private_dot_xxx` | 部署后权限 0600 |
| `encrypted_dot_xxx` | 仓库里加密存储，部署时解密 |

---

## Profile 系统：work / personal

仓库里有些内容**只有 work 才需要**。机制：

1. **整段隔离**：work 专属内容放独立文件 `dot_zshrc.work`
2. **`.chezmoiignore`** 是模板，按 profile 决定是否 ignore：
   ```
   {{- if ne .profile "work" }}
   .zshrc.work
   {{- end }}
   ```
3. **主 .zshrc 末尾**条件 source：
   ```
   [[ -f ~/.zshrc.work ]] && source ~/.zshrc.work
   [[ -f ~/.zshrc.personal ]] && source ~/.zshrc.personal
   ```

效果：personal 机不部署 `.zshrc.work`，那行 source 自动跳过；work 机正常加载。

### 加新的 work 专属配置

直接编辑 `~/.zshrc.work` → `chezmoi add` → push。

### 加 personal 专属配置

```sh
chezmoi cd
touch dot_zshrc.personal
# 改 .chezmoiignore 加一行：{{- if ne .profile "personal" }} .zshrc.personal {{- end }}
```

---

## 模板变量

`.tmpl` 文件里可用：

| 变量 | 来源 | 值 |
|---|---|---|
| `{{ .profile }}` | 首次 init 选择 | `"work"` / `"personal"` |
| `{{ .git.name }}` | 首次 init 输入 | git user.name |
| `{{ .git.email }}` | 首次 init 输入 | git user.email（可空） |
| `{{ .chezmoi.os }}` | 内置 | `"darwin"` / `"linux"` |
| `{{ .chezmoi.hostname }}` | 内置 | 主机名 |
| `{{ .chezmoi.username }}` | 内置 | 系统用户名 |

例：

```
{{- if eq .profile "work" }}
# work 专属
{{- end }}

{{- if eq .chezmoi.os "linux" }}
# Linux 专属
{{- end }}
```

---

## Bitwarden secrets

不想把 token / API key 明文存仓库时用：

```sh
bw login                                   # 一次性
export BW_SESSION=$(bw unlock --raw)       # 每次新 shell 解锁（或写进 .zshrc）
```

模板里取值：

```
{{ (bitwardenFields "item" "GitHub PAT").token.value }}
```

`chezmoi apply` 时自动拉取并渲染。

---

## 平台支持矩阵

|  | macOS | Fedora | 说明 |
|---|---|---|---|
| 自动 brew/dnf 装包 | ✅ | ✅ | Fedora 默认源缺的会用脚本/二进制装 |
| Ghostty | ✅ cask | ❌ | Linux 上不需要（用别的终端） |
| Zellij | ✅ brew | ⚠️ 手动 | Fedora 没在默认源，提示下载二进制 |
| Bitwarden CLI | ✅ brew | ⚠️ 手动 | 同上 |
| 配置文件 | ✅ | ✅ | 全部跨平台 |

---

## Troubleshooting

### `chezmoi apply` 报 "config file template has changed"

```sh
chezmoi init       # 不带 URL，等同于重新渲染 chezmoi.toml
```

不会重 clone，只重渲染本机配置文件。

### nvim 在大项目里渲染慢

zellij 的 `serialize_pane_viewport` 在重绘频繁的 TUI 里有性能开销。本仓库已禁用，仅保留 `session_serialization` 做 layout 恢复。

### 临时禁用某个 profile-specific 文件

编辑 `~/.config/chezmoi/chezmoi.toml`，改 `profile` 后 `chezmoi apply`。

---

## 提交规范

[Conventional Commits](https://www.conventionalcommits.org/)：`feat:` / `fix:` / `refactor:` / `chore:` / `docs:`。
