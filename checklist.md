# Windows 全栈优化清单

> 机型：Dell Inspiron 7590 · Windows 11 Pro · i5-9300H · 16GB · GTX 1650

每条目标注：🔴 必须 / 🟡 推荐 / 🟢 可选 · 是否已配置：⬜ 未 · ✅ 已

---

## 🔴 更新控制

| # | 条目 | 优先级 | 方法 | 状态 |
|---|------|:---:|------|:---:|
| 1 | 暂停更新 100 年 | 🔴 | `scripts/disable-updates.reg` 导入注册表 | ⬜ |
| 2 | 禁用 Windows Update 服务 | 🟡 | `services.msc` → wuauserv → 禁用 | ⬜ |
| 3 | 禁止任务计划唤醒更新 | 🔴 | `taskschd.msc` → WindowsUpdate → 禁用所有任务 | ⬜ |
| 4 | 关闭传递优化 | 🟡 | 设置 → Windows 更新 → 高级选项 → 传递优化 → 关 | ⬜ |
| 5 | 卸载 Microsoft Update Health Tools | 🟡 | 控制面板 → 程序和功能 → 卸载 | ⬜ |

## 🔒 隐私 & 遥测

| # | 条目 | 优先级 | 方法 | 状态 |
|---|------|:---:|------|:---:|
| 6 | 诊断数据设为「必需」 | 🔴 | `scripts/privacy-tweaks.reg` | ⬜ |
| 7 | 关闭广告 ID | 🔴 | `scripts/privacy-tweaks.reg` | ⬜ |
| 8 | 关闭活动历史记录 | 🔴 | `scripts/privacy-tweaks.reg` | ⬜ |
| 9 | 关闭位置服务 | 🟡 | 设置 → 隐私 → 位置 → 关 | ⬜ |
| 10 | 关闭语音识别 | 🟡 | 设置 → 隐私 → 语音 → 关 | ⬜ |

## 🧹 预装垃圾

| # | 条目 | 优先级 | 方法 | 状态 |
|---|------|:---:|------|:---:|
| 11 | 卸载预装 UWP 应用 | 🔴 | Winhance 一键卸载 或 `winget uninstall` | ⬜ |
| 12 | 卸载/禁用小组件 | 🔴 | `winget uninstall "Windows Web Experience Pack"` | ⬜ |
| 13 | 移除 Edge 自启和后台 | 🟡 | 设置 → 应用 → 启动 → Edge → 关 | ⬜ |
| 14 | 关闭 OneDrive 自动同步 | 🟡 | OneDrive 设置 → 取消链接此电脑 | ⬜ |

## 🖥️ UI 修复

| # | 条目 | 优先级 | 方法 | 状态 |
|---|------|:---:|------|:---:|
| 15 | 恢复经典右键菜单 | 🔴 | `scripts/classic-context-menu.reg` | ⬜ |
| 16 | 任务栏按钮不合并 | 🔴 | ExplorerPatcher 或 Windhawk mod | ⬜ |
| 17 | 关闭搜索栏新闻/高亮 | 🟡 | `scripts/lock-screen-ads.reg` | ⬜ |
| 18 | 关闭锁屏广告 | 🟡 | `scripts/lock-screen-ads.reg` | ⬜ |
| 19 | 关闭开始菜单推荐 | 🟡 | 设置 → 个性化 → 开始 → 关「显示建议」 | ⬜ |

## 🔤 字体 & 显示

| # | 条目 | 优先级 | 方法 | 状态 |
|---|------|:---:|------|:---:|
| 20 | ClearType 校准 | 🔴 | `Win + R` → `cttune.exe` → 按向导校准 | ⬜ |
| 21 | 整数倍 DPI 缩放（100%/150%/200%） | 🟡 | 设置 → 系统 → 屏幕 → 缩放 | ⬜ |
| 22 | 安装 JetBrainsMono Nerd Font | 🔴 | `winget install JetBrainsMono.NerdFont` | ⬜ |

## 🕐 时间同步

| # | 条目 | 优先级 | 方法 | 状态 |
|---|------|:---:|------|:---:|
| 23 | 换用阿里云 NTP | 🔴 | `w32tm` 命令配置 `ntp.aliyun.com` | ⬜ |
| 24 | 关闭自动时区 | 🟡 | 设置 → 时间和语言 → 日期和时间 → 关 | ⬜ |

## 🎮 GPU 利用

| # | 条目 | 优先级 | 方法 | 状态 |
|---|------|:---:|------|:---:|
| 25 | 安装 NVIDIA 最新驱动 | 🔴 | GeForce Experience 或 nvidia.com | ⬜ |
| 26 | 安装 CUDA Toolkit + cuDNN | 🟡 | 见 `notes/gpu-setup.md` | ⬜ |
| 27 | 安装 Ollama 本地 LLM | 🟡 | `winget install Ollama.Ollama` | ⬜ |
| 28 | 配置 NVENC 硬件编码 | 🟢 | FFmpeg/OBS 启用 NVENC | ⬜ |
| 29 | WSL2 GPU 直通 | 🟡 | 见 `notes/gpu-setup.md` | ⬜ |
| 30 | 浏览器强制使用独显 | 🟢 | NVIDIA 控制面板 → 3D 设置 → 选择 GTX 1650 | ⬜ |

## 🔧 开发环境

| # | 条目 | 优先级 | 方法 | 状态 |
|---|------|:---:|------|:---:|
| 31 | 安装 Git | 🔴 | `winget install Git.Git`（或镜像下载） | ✅ |
| 32 | 配置 Git 全局信息 | 🔴 | `git config --global user.name/email` | ✅ |
| 33 | 安装 VS Code | 🔴 | `winget install Microsoft.VisualStudioCode` | ⬜ |
| 34 | 安装 PowerShell 7 | 🟡 | `winget install Microsoft.PowerShell` | ⬜ |
| 35 | 安装 Scoop 包管理器 | 🔴 | `irm get.scoop.sh \| iex` | ⬜ |
| 36 | 安装 WSL2 + Ubuntu | 🟡 | `wsl --install` | ⬜ |
| 37 | 安装 Windows Terminal / WezTerm | 🔴 | `winget install Microsoft.WindowsTerminal` | ⬜ |

## ⚡ 现代 CLI

| # | 条目 | 替代 | 安装 | 状态 |
|---|------|------|------|:---:|
| 38 | eza | `ls` | `scoop install eza` | ⬜ |
| 39 | bat | `cat` | `scoop install bat` | ⬜ |
| 40 | ripgrep (rg) | `grep` | `scoop install ripgrep` | ⬜ |
| 41 | fd | `find` | `scoop install fd` | ⬜ |
| 42 | zoxide | `cd` | `scoop install zoxide` | ⬜ |
| 43 | delta | `git diff` | `scoop install delta` | ⬜ |
| 44 | dust | `du` | `scoop install dust` | ⬜ |
| 45 | duf | `df` | `scoop install duf` | ⬜ |
| 46 | bottom (btm) | `top` | `scoop install bottom` | ⬜ |
| 47 | procs | `ps` | `scoop install procs` | ⬜ |
| 48 | sd | `sed` | `scoop install sd` | ⬜ |
| 49 | tldr | `man` | `scoop install tldr` | ⬜ |
| 50 | xh | `curl` | `scoop install xh` | ⬜ |
| 51 | jq | JSON | `scoop install jq` | ⬜ |
| 52 | mcfly | `Ctrl-R` | `scoop install mcfly` | ⬜ |
| 53 | gping | `ping` | `scoop install gping` | ⬜ |
| 54 | glow | markdown | `scoop install glow` | ⬜ |
| 55 | difftastic | `diff` | `scoop install difftastic` | ⬜ |

## 📝 编辑器

| # | 条目 | 优先级 | 方法 | 状态 |
|---|------|:---:|------|:---:|
| 56 | 安装 Neovim | 🔴 | `scoop install neovim` | ⬜ |
| 57 | 部署 LazyVim | 🔴 | `git clone LazyVim/starter → $env:LOCALAPPDATA\nvim` | ⬜ |
| 58 | 安装 LazyVim 依赖 | 🔴 | `scoop install ripgrep fd lazygit gcc` | ⬜ |

## 🎨 Shell 提示 & 桌面美化

| # | 条目 | 优先级 | 方法 | 状态 |
|---|------|:---:|------|:---:|
| 59 | Oh My Posh 提示符 | 🟡 | `winget install JanDeDobbeleer.OhMyPosh` | ⬜ |
| 60 | Starship 提示符（备选） | 🟢 | `winget install Starship.Starship` | ⬜ |
| 61 | fzf + PSReadLine 集成 | 🟡 | PowerShell Profile 中配置 | ⬜ |
| 62 | Terminal-Icons | 🟢 | `Install-Module Terminal-Icons` | ⬜ |
| 63 | Windhawk 桌面 Mod | 🟡 | `winget install RamenSoftware.Windhawk` | ⬜ |
| 64 | GlazeWM 平铺窗口 | 🟢 | `scoop install glazewm` | ⬜ |
| 65 | ExplorerPatcher 任务栏修复 | 🔴 | `winget install valinet.ExplorerPatcher` | ⬜ |

## ⚙️ 系统版本

| # | 条目 | 优先级 | 方法 | 状态 |
|---|------|:---:|------|:---:|
| 66 | 锁定 25H2 | 🔴 | 组策略或注册表暂停功能更新 | ⬜ |
| 67 | 安全更新仅装关键补丁 | 🟡 | Windows 更新 → 高级选项 | ⬜ |
| 68 | 参考版本对比 | 🟢 | 见 `notes/windows-versions.md` | ✅ |

---

## 一键执行

```powershell
# 管理员终端中运行
cd scripts
.\tweaks.ps1
```

总计 **68 项**，标注 🔴 的 28 项强烈建议完成。