# Mac → Windows 开发工具对照表

## 终端到桌面

| 用途 | Mac | Windows |
|------|-----|---------|
| 终端 | Ghostty | **WezTerm** / Windows Terminal |
| 编辑器 | LazyVim | **Neovim + LazyVim**（完全一样） |
| Shell | zsh / fish | **PowerShell 7** |
| 包管理 | Homebrew | **Scoop** + winget |
| 字体 | 等宽字体 | JetBrainsMono Nerd Font |
| 提示符 | Starship | Oh My Posh / Starship |
| 平铺 WM | yabai / Aerospace | GlazeWM / Komorebi |
| 启动器 | Raycast / Alfred | Flow Launcher |

## 现代 CLI 全对照

| 传统命令 | 现代替代 | Scoop 安装 |
|----------|----------|-----------|
| `ls` | `eza` | `scoop install eza` |
| `cat` | `bat` | `scoop install bat` |
| `grep` | `ripgrep` (rg) | `scoop install ripgrep` |
| `find` | `fd` | `scoop install fd` |
| `cd` (智能) | `zoxide` (z) | `scoop install zoxide` |
| `git diff` | `delta` | `scoop install delta` |
| `du` | `dust` | `scoop install dust` |
| `df` | `duf` | `scoop install duf` |
| `top` | `bottom` (btm) | `scoop install bottom` |
| `ps` | `procs` | `scoop install procs` |
| `sed` | `sd` | `scoop install sd` |
| `man` | `tldr` | `scoop install tldr` |
| `curl` | `xh` | `scoop install xh` |
| `ping` | `gping` | `scoop install gping` |
| JSON | `jq` | `scoop install jq` |
| `Ctrl-R` | `mcfly` | `scoop install mcfly` |
| Markdown | `glow` | `scoop install glow` |
| `diff` | `difftastic` | `scoop install difftastic` |

## 一键安装命令

```powershell
# 1. 安装 Scoop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

# 2. 安装所有现代 CLI
scoop install eza bat ripgrep fd zoxide delta dust duf bottom procs sd fzf tldr xh jq mcfly gping glow difftastic

# 3. 安装 Neovim + LazyVim
scoop install neovim ripgrep fd lazygit gcc
git clone https://github.com/LazyVim/starter $env:LOCALAPPDATA\nvim

# 4. 安装字体
winget install JetBrainsMono.NerdFont

# 5. 安装终端
winget install Microsoft.WindowsTerminal
# 或
scoop install wezterm
```

## Ghostty 在 Windows 上的现状

Ghostty 目前没有官方 Windows 版本。社区有自行编译的版本，但缺少输入法集成、高分屏缩放等原生适配。**WezTerm 是最接近 Ghostty 体验的选择**——Lua 配置、GPU 加速、跨平台一致。