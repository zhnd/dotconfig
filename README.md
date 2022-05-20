# 面向前端开发的 neovim 配置

为了练习 vim 编程方式，参考日常使用习惯，将自己的配置文件夹同步至此仓库，多设备同步，方便查看。

基于自身技术栈以及学习内容，主要支持一下文件类型：

- JavaScript
- TypeScript
- HTML
- CSS
- Less
- TypeScriptReact
- Rust

## 目前实现的主要功能：

- 使用内置[lsp](https://microsoft.github.io/language-server-protocol/) 客户端
- 自动提示、方法、文件跳转
- 代码片段
- 文件树
- 代码高亮
- code runner
- 终端集成
- [lazygit](https://github.com/jesseduffield/lazygit)集成
- 保存自动格式化
- [packer](https://github.com/wbthomason/packer.nvim)插件管理

## 使用指南

可直接 clone 本仓库到用户目录下，目前这个项目的配置内容仅在 MaxOS 进行测试，欢迎各位伙伴试用并 commit fix and feat mr。

需要手动安装各种依赖：

### 通用依赖

这些内容可以脱离 neovim 单独在终端中使用：

- Nodejs
- Python
- neovim：[安装文档](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- lazygit：[安装文档](https://github.com/jesseduffield/lazygit#installation)

### lsp 依赖

这些内容是使用本配置的依赖，可在第一次启动 neovim 的时候按照提示依次安装：

#### npm install -g

- emmet-ls
- vscode-langservers-extracted
- typescript
- typescript-language-server

一键安装：

```bash
npm install -g emmet-ls vscode-langservers-extracted typescript typescript-language-server
```

如果你需要更新 Lua 配置文件，还需要安装

- lua-language-server：[安装文档](https://github.com/sumneko/lua-language-server/wiki/Build-and-Run)

如果你碰巧也在学习 Rust，还需要安装：

- Rust，强烈推荐使用 rustup：

```rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

- rust_analyzer：[安装文档](https://rust-analyzer.github.io/manual.html#installation)

## 常用快捷键

<details>
<summary>基本操作</summary>

<pre>
  <kbd>u:</kbd>: 撤销
  <kbd>r:</kbd>: 替换光标下的字符，不进入插入模式，例如rx，将光标下的字符替换为x
  <kbd>ndd</kbd>: 删除从光标所在行开始，向下的n行
  <kbd>x</kbd>: 每按一次，删除光标所在位置的“后面”一个字符。
  <kbd>nx</kbd>:删除光标所在位置的“后面”n个字符
  <kbd>X</kbd>: 每按一次，删除光标所在位置的“前面”一个字符
  <kbd>nX</kbd>: 删除光标所在位置的“前面”n个字符
  <kbd>:history</kbd>: 显示最近在vim里面输入的历史
  <kbd>gcc</kbd>: 注释一行
  <kbd><<</kbd>: 左移一行
  <kbd>>></kbd>: 右移一行
  <kbd>c?change</kbd>: (先删除再进入插入模式)
  <kbd>d?delete</kbd>: 先删除
  <kbd>p</kbd>: 从光标右边开始粘贴，注意不能粘贴到Vim外的程序中
  <kbd>P</kbd>: 大P，从光标左边开始粘贴
  <kbd>yy</kbd>: 复制一整行
  <kbd>y$</kbd>:  复制从光标所在位置，到行尾的所有字符
  <kbd>y0</kbd>: （复制从光标所在位置，到行首的所有字符
  <kbd>~? </kbd>: 转换大小写
  <kbd>gu</kbd>: 转为小写
  <kbd>guiw</kbd>: 就是让一个单词变成小写
  <kbd>gUiw</kbd>: 就是让一个单词变成大写
  <kbd>>?</kbd>:shift right (右移)
  <kbd><?</kbd>:shift left (左移)
  <kbd>diw</kbd>: 删除一个单词，只删除单词本身，不会旁边的空格
  <kbd>daw</kbd>: 删除一个单词，并删除旁边的一个空格
  <kbd>viw</kbd>: 就表示选中一个单词
  <kbd>yiw</kbd>: 表示复制一个单词
</pre>
</details>

<details>
<summary>动作命令</summary>

<pre>
  <kbd>f{char}find</kbd>: 行内搜索一个字符
  <kbd>t{char}till</kbd>: 功能类型 f{chat}, 但是是在这个搜索到的字符前停下，意思是到这个字符之前，很常用的motion
  <kbd>gg</kbd>:跳到行首
  <kbd>G</kbd>:跳到行尾
  <kbd>w</kbd>:移到下个单词的第一个字符
  <kbd>b</kbd>:移到上个单词的第一个字符
  <kbd>e</kbd>:移到单词最后一个字符
  <kbd>ge</kbd>:上个单词的最后一个字符
  <kbd>vaw “a word”</kbd>: 选择一整个单词，包括它边上的空格
  <kbd>viw in word</kbd>: 选择一整个单词，不包括空格

</pre>
</details>

<details>
<summary>vim-surround</summary>

<pre>
   <kbd>ysiw"</kbd>: 单词周围加双引号
   <kbd>ysiw(</kbd>: 单词周围加圆括号, 左括号是带空格的
   <kbd>ysiw]</kbd>: 单词周围加方括号, 右括号不带空格
   <kbd>ysiWb</kbd>: 以空格为分界加圆括号,这是不带空格的括号，大 B 代表不带空格的花括号
   <kbd>ysfn</kbd>: 从光标位置到字母 n 加
   <kbd>ystn</kbd>: 从光标位置到字母 n 前面加
   <kbd>yss</kbd>: 整行前后加
   <kbd>v</kbd>: 选中，S v 模式选中区域前后加
   <kbd>cs'"</kbd>: 双引号改单引号,作用于整行
   <kbd>ds"</kbd>: 删除双引号,作用于整行
</pre>
</details>

<details>
<summary>vim-easymotion</summary>

<pre>
  <kbd>leader leader s <char></kbd>全文查找字符
  <kbd>leader leader w</kbd>查找当前光标后面的单词首字母
  <kbd>leader leader b</kbd>查找当前光标前面的单词首字母
</pre>

</details>

****
### normal mode

#### 自定义

| 快捷键      | 说明                      |
| ----------- | ------------------------- |
| jj          | ESC                       |
| leader + e  | :NvimTreeToggle           |
| leader + f  | vim.diagnostic.open_float |
| leader + ff | telscope.find_files       |
| leader + fg | telscope.live_grep        |
| leader + fb | telscope.buffers          |
| leader + fh | telscope.help_tags        |
| leader + g  | lazygit_toggle            |
| leader + r  | :QuickRun                 |
| leader + dd | :Dash                     |

#### 插件

<details>
<summary>Lazygit</summary>

- 全局键绑定

<pre>
  <kbd>ctrl+r</kbd>: 切换到最近的仓库
  <kbd>pgup</kbd>: 向上滚动主面板 (fn+up/shift+k)
  <kbd>pgdown</kbd>: 向下滚动主面板 (fn+down/shift+j)
  <kbd>m</kbd>: 查看 合并/变基 选项
  <kbd>ctrl+p</kbd>: 查看自定义补丁选项
  <kbd>R</kbd>: 刷新
  <kbd>x</kbd>: 打开菜单
  <kbd>+</kbd>: 下一屏模式（正常/半屏/全屏）
  <kbd>_</kbd>: 上一屏模式
  <kbd>ctrl+s</kbd>: 查看按路径过滤选项
  <kbd>W</kbd>: 打开 diff 菜单
  <kbd>ctrl+e</kbd>: 打开 diff 菜单
  <kbd>@</kbd>: 打开命令日志菜单
  <kbd>}</kbd>: 扩大差异视图中显示的上下文范围
  <kbd>{</kbd>: 缩小差异视图中显示的上下文范围
  <kbd>:</kbd>: 执行自定义命令
  <kbd>z</kbd>: （通过 reflog）撤销「实验功能」
  <kbd>ctrl+z</kbd>: （通过 reflog）重做「实验功能」
  <kbd>P</kbd>: 推送
  <kbd>p</kbd>: 拉取
</pre>

- 列表面板导航

<pre>
  <kbd>.</kbd>: 下一页
  <kbd>,</kbd>: 上一页
  <kbd><</kbd>: 滚动到顶部
  <kbd>></kbd>: 滚动到底部
  <kbd>/</kbd>: 开始搜索
  <kbd>H</kbd>: 向左滚动
  <kbd>L</kbd>: 向右滚动
  <kbd>]</kbd>: 下一个标签
  <kbd>[</kbd>: 上一个标签
</pre>

- Reflog 页面

<pre>
  <kbd>ctrl+o</kbd>: 将提交的 SHA 复制到剪贴板
  <kbd>space</kbd>: 检出提交
  <kbd>y</kbd>: copy commit attribute
  <kbd>o</kbd>: 在浏览器中打开提交
  <kbd>n</kbd>: 从提交创建新分支
  <kbd>g</kbd>: 查看重置选项
  <kbd>c</kbd>: 复制提交（拣选）
  <kbd>C</kbd>: 复制提交范围（拣选）
  <kbd>ctrl+r</kbd>: 重置已拣选（复制）的提交
  <kbd>enter</kbd>: 查看提交
</pre>

- 分支页面

<pre>
  <kbd>ctrl+o</kbd>: 将分支名称复制到剪贴板
  <kbd>i</kbd>: 显示 git-flow 选项
  <kbd>space</kbd>: 检出
  <kbd>n</kbd>: 新分支
  <kbd>o</kbd>: 创建抓取请求
  <kbd>O</kbd>: 创建抓取请求选项
  <kbd>ctrl+y</kbd>: 将抓取请求 URL 复制到剪贴板
  <kbd>c</kbd>: 按名称检出
  <kbd>F</kbd>: 强制检出
  <kbd>d</kbd>: 删除分支
  <kbd>r</kbd>: 将已检出的分支变基到该分支
  <kbd>M</kbd>: 合并到当前检出的分支
  <kbd>f</kbd>: 从上游快进此分支
  <kbd>g</kbd>: 查看重置选项
  <kbd>R</kbd>: 重命名分支
  <kbd>u</kbd>: set/unset upstream
  <kbd>enter</kbd>: 查看提交
</pre>

- 子提交

<pre>
  <kbd>ctrl+o</kbd>: 将提交的 SHA 复制到剪贴板
  <kbd>space</kbd>: 检出提交
  <kbd>y</kbd>: copy commit attribute
  <kbd>o</kbd>: 在浏览器中打开提交
  <kbd>n</kbd>: 从提交创建新分支
  <kbd>g</kbd>: 查看重置选项
  <kbd>c</kbd>: 复制提交（拣选）
  <kbd>C</kbd>: 复制提交范围（拣选）
  <kbd>ctrl+r</kbd>: 重置已拣选（复制）的提交
  <kbd>enter</kbd>: 查看提交的文件
</pre>

- 子模块

<pre>
  <kbd>ctrl+o</kbd>: 将子模块名称复制到剪贴板
  <kbd>enter</kbd>: 输入子模块
  <kbd>d</kbd>: 删除子模块
  <kbd>u</kbd>: 更新子模块
  <kbd>n</kbd>: 添加新的子模块
  <kbd>e</kbd>: 更新子模块 URL
  <kbd>i</kbd>: 初始化子模块
  <kbd>b</kbd>: 查看批量子模块选项
</pre>

- 提交

<pre>
  <kbd>ctrl+o</kbd>: 将提交的 SHA 复制到剪贴板
  <kbd>ctrl+r</kbd>: 重置已拣选（复制）的提交
  <kbd>b</kbd>: 查看二分查找选项
  <kbd>s</kbd>: 向下压缩
  <kbd>f</kbd>: 修正提交（fixup）
  <kbd>r</kbd>: 改写提交
  <kbd>R</kbd>: 使用编辑器重命名提交
  <kbd>d</kbd>: 删除提交
  <kbd>e</kbd>: 编辑提交
  <kbd>p</kbd>: 选择提交（变基过程中）
  <kbd>F</kbd>: 为此提交创建修正
  <kbd>S</kbd>: 压缩在所选提交之上的所有“fixup!”提交（自动压缩）
  <kbd>ctrl+j</kbd>: 下移提交
  <kbd>ctrl+k</kbd>: 上移提交
  <kbd>v</kbd>: 粘贴提交（拣选）
  <kbd>A</kbd>: 用已暂存的更改来修补提交
  <kbd>a</kbd>: reset commit author
  <kbd>t</kbd>: 还原提交
  <kbd>T</kbd>: 标签提交
  <kbd>ctrl+l</kbd>: 打开日志菜单
  <kbd>space</kbd>: 检出提交
  <kbd>y</kbd>: copy commit attribute
  <kbd>o</kbd>: 在浏览器中打开提交
  <kbd>n</kbd>: 从提交创建新分支
  <kbd>g</kbd>: 查看重置选项
  <kbd>c</kbd>: 复制提交（拣选）
  <kbd>C</kbd>: 复制提交范围（拣选）
  <kbd>enter</kbd>: 查看提交的文件
</pre>

- 提交文件

<pre>
  <kbd>ctrl+o</kbd>: 将提交的文件名复制到剪贴板
  <kbd>c</kbd>: 检出文件
  <kbd>d</kbd>: 放弃对此文件的提交更改
  <kbd>o</kbd>: 打开文件
  <kbd>e</kbd>: 编辑文件
  <kbd>space</kbd>: 补丁中包含的切换文件
  <kbd>a</kbd>: toggle all files included in patch
  <kbd>enter</kbd>: 输入文件以将所选行添加到补丁中（或切换目录折叠）
  <kbd>`</kbd>: 切换文件树视图
</pre>

- 文件

<pre>
  <kbd>ctrl+o</kbd>: 将文件名复制到剪贴板
  <kbd>ctrl+w</kbd>: 切换是否在差异视图中显示空白字符差异
  <kbd>d</kbd>: 查看'放弃更改'选项
  <kbd>space</kbd>: 切换暂存状态
  <kbd>ctrl+b</kbd>: Filter files (staged/unstaged)
  <kbd>c</kbd>: 提交更改
  <kbd>w</kbd>: 提交更改而无需预先提交钩子
  <kbd>A</kbd>: 修补最后一次提交
  <kbd>C</kbd>: 提交更改（使用编辑器编辑提交信息）
  <kbd>e</kbd>: 编辑文件
  <kbd>o</kbd>: 打开文件
  <kbd>i</kbd>: 添加到 .gitignore
  <kbd>r</kbd>: 刷新文件
  <kbd>s</kbd>: 将所有更改加入贮藏
  <kbd>S</kbd>: 查看贮藏选项
  <kbd>a</kbd>: 切换所有文件的暂存状态
  <kbd>enter</kbd>: 暂存单个 块/行 用于文件, 或 折叠/展开 目录
  <kbd>g</kbd>: 查看上游重置选项
  <kbd>D</kbd>: 查看重置选项
  <kbd>`</kbd>: 切换文件树视图
  <kbd>M</kbd>: 打开外部合并工具 (git mergetool)
  <kbd>f</kbd>: 抓取
</pre>

- 构建补丁中

<pre>
  <kbd>esc</kbd>: 退出逐行模式
  <kbd>o</kbd>: 打开文件
  <kbd>▲</kbd>: 选择上一行
  <kbd>▼</kbd>: 选择下一行
  <kbd>◄</kbd>: 选择上一个区块
  <kbd>►</kbd>: 选择下一个区块
  <kbd>ctrl+o</kbd>: 将选中文本复制到剪贴板
  <kbd>space</kbd>: 添加/移除 行到补丁
  <kbd>v</kbd>: 切换拖动选择
  <kbd>V</kbd>: 切换拖动选择
  <kbd>a</kbd>: 切换选择区块
</pre>

- 标签页面

<pre>
  <kbd>space</kbd>: 检出
  <kbd>d</kbd>: 删除标签
  <kbd>P</kbd>: 推送标签
  <kbd>n</kbd>: 创建标签
  <kbd>g</kbd>: 查看重置选项
  <kbd>enter</kbd>: 查看提交
</pre>

- 正在合并

<pre>
  <kbd>esc</kbd>: 返回文件面板
  <kbd>M</kbd>: 打开外部合并工具 (git mergetool)
  <kbd>space</kbd>: 选中区块
  <kbd>b</kbd>: 选中所有区块
  <kbd>◄</kbd>: 选择上一个冲突
  <kbd>►</kbd>: 选择下一个冲突
  <kbd>▲</kbd>: 选择顶部块
  <kbd>▼</kbd>: 选择底部块
  <kbd>e</kbd>: 编辑文件
  <kbd>o</kbd>: 打开文件
  <kbd>z</kbd>: 撤销
</pre>

- 正在暂存

<pre>
  <kbd>esc</kbd>: 返回文件面板
  <kbd>space</kbd>: 切换行暂存状态
  <kbd>d</kbd>: 取消变更 (git reset)
  <kbd>tab</kbd>: 切换到其他面板
  <kbd>o</kbd>: 打开文件
  <kbd>▲</kbd>: 选择上一行
  <kbd>▼</kbd>: 选择下一行
  <kbd>◄</kbd>: 选择上一个区块
  <kbd>►</kbd>: 选择下一个区块
  <kbd>ctrl+o</kbd>: 将选中文本复制到剪贴板
  <kbd>e</kbd>: 编辑文件
  <kbd>v</kbd>: 切换拖动选择
  <kbd>V</kbd>: 切换拖动选择
  <kbd>a</kbd>: 切换选择区块
  <kbd>E</kbd>: edit hunk
</pre>

- 正常

<pre>
  <kbd>mouse wheel down</kbd>: 向下滚动 (fn+up)
  <kbd>mouse wheel up</kbd>: 向上滚动 (fn+down)
</pre>

- 状态

<pre>
  <kbd>e</kbd>: 编辑配置文件
  <kbd>o</kbd>: 打开配置文件
  <kbd>u</kbd>: 检查更新
  <kbd>enter</kbd>: 切换到最近的仓库
  <kbd>a</kbd>: 显示所有分支的日志
</pre>

- 贮藏

<pre>
  <kbd>space</kbd>: 应用
  <kbd>g</kbd>: 应用并删除
  <kbd>d</kbd>: 删除
  <kbd>n</kbd>: 新分支
  <kbd>enter</kbd>: 查看提交的文件
</pre>

- 远程分支

<pre>
  <kbd>space</kbd>: 检出
  <kbd>n</kbd>: 新分支
  <kbd>M</kbd>: 合并到当前检出的分支
  <kbd>r</kbd>: 将已检出的分支变基到该分支
  <kbd>d</kbd>: 删除分支
  <kbd>u</kbd>: 设置为检出分支的上游
  <kbd>esc</kbd>: 返回远程仓库列表
  <kbd>g</kbd>: 查看重置选项
  <kbd>enter</kbd>: 查看提交
</pre>

- 远程页面

<pre>
  <kbd>f</kbd>: 抓取远程仓库
  <kbd>n</kbd>: 添加新的远程仓库
  <kbd>d</kbd>: 删除远程
  <kbd>e</kbd>: 编辑远程仓库
</pre>

</details>

<details>
  <summary>neovim tree</summary>

<pre>
<code>
-- default mappings
local list = {
  { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit" },
  { key = "<C-e>",                        action = "edit_in_place" },
  { key = {"O"},                          action = "edit_no_picker" },
  { key = {"<2-RightMouse>", "<C-]>"},    action = "cd" },
  { key = "<C-v>",                        action = "vsplit" },
  { key = "<C-x>",                        action = "split" },
  { key = "<C-t>",                        action = "tabnew" },
  { key = "<",                            action = "prev_sibling" },
  { key = ">",                            action = "next_sibling" },
  { key = "P",                            action = "parent_node" },
  { key = "<BS>",                         action = "close_node" },
  { key = "<Tab>",                        action = "preview" },
  { key = "K",                            action = "first_sibling" },
  { key = "J",                            action = "last_sibling" },
  { key = "I",                            action = "toggle_git_ignored" },
  { key = "H",                            action = "toggle_dotfiles" },
  { key = "R",                            action = "refresh" },
  { key = "a",                            action = "create" },
  { key = "d",                            action = "remove" },
  { key = "D",                            action = "trash" },
  { key = "r",                            action = "rename" },
  { key = "<C-r>",                        action = "full_rename" },
  { key = "x",                            action = "cut" },
  { key = "c",                            action = "copy" },
  { key = "p",                            action = "paste" },
  { key = "y",                            action = "copy_name" },
  { key = "Y",                            action = "copy_path" },
  { key = "gy",                           action = "copy_absolute_path" },
  { key = "[c",                           action = "prev_git_item" },
  { key = "]c",                           action = "next_git_item" },
  { key = "-",                            action = "dir_up" },
  { key = "s",                            action = "system_open" },
  { key = "f",                            action = "live_filter" },
  { key = "F",                            action = "clear_live_filter" },
  { key = "q",                            action = "close" },
  { key = "g?",                           action = "toggle_help" },
  { key = "W",                            action = "collapse_all" },
  { key = "S",                            action = "search_node" },
  { key = "<C-k>",                        action = "toggle_file_info" },
  { key = ".",                            action = "run_file_command" }
}
</code>
</pre>
</details>
