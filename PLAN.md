# Windows 全栈优化清单 → GitHub 同步计划

## 上下文

用户有一台 Windows 11 Pro 笔记本，希望：
1. 把之前讨论的所有 Windows 优化项整理成一份清单
2. 将这份清单、PowerShell 配置等内容作为一个综合仓库推送到 GitHub
3. 仓库既包含 Windows 优化清单，也包含 dotfiles 配置
4. 当前电脑没有安装 Git，没有任何 Git 配置

### 硬件配置全貌

| 组件 | 型号 | 备注 |
|------|------|------|
| 机型 | **Dell Inspiron 7590** | BIOS 1.3.0, SN: B23SN42, 主板 08717F Rev A00 |
| OS | Windows 11 Pro, Build 26200 | 25H2 阶段 |
| CPU | Intel i5-9300H, 4C8T @ 2.40GHz | 够用 |
| 内存 | 16 GB DDR4-2667 | 2×8GB（SK Hynix + Samsung 混搭） |
| 核显 | Intel UHD Graphics 630, 1 GB | 驱动桌面显示 |
| 独显 | **NVIDIA GeForce GTX 1650, 4 GB** | Turing 架构，896 CUDA Cores，NVENC |
| SSD | WD PC SN520 NVMe 512GB | Health=Healthy，但 C 盘 97.7% 满 |
| 电池 | ⚠️ 已拆除 | 仅 AC 供电 |
| 虚拟显卡 | OrayIddDriver（向日葵） | 远程桌面软件装的 |

## 前置条件

- Git：未安装
- winget：已安装（v1.29.380）
- GitHub 账号：用户有账号，用户名和邮箱待确认
- SSH Key：未生成，待创建
- 网络：GitHub 22/443 端口均通 ✅

## 硬件健康评估（2026-10-11）

### 体检结果

| 组件 | 状态 | 体检记录 |
|------|:---:|------|
| **SSD** | ⚠️ | WD PC SN520 NVMe 512GB，HealthStatus=Healthy。⚠️ **C 盘仅剩 10.4 GB（97.7% 满）**——必须在安装任何新软件之前清理 |
| **CPU** | 🟢 | i5-9300H，4C8T，无过热降频记录，电源方案「平衡」，无崩溃 |
| **内存** | 🟢 | 16 GB DDR4-2667，两根 8GB（SK Hynix + Samsung 混搭），无错误 |
| **独显** | 🟢 | GTX 1650 4GB，驱动正常 |
| **电池** | 🔴 | **已拆除**，仅 AC 供电。意外断电 → 立即关机 + 数据丢失风险 |
| **风扇** | 🟡 | 有主动散热，但机器已 7 年，未检查灰尘/硅脂 |
| **系统稳定** | 🟢 | 最近无崩溃、无磁盘错误 |

### 能不能跑我们计划的配置？

| 计划中的工作 | 负载评估 | 能不能跑 |
|-------------|----------|:---:|
| Git、VS Code、WSL2 | 轻 | ✅ 绰绰有余 |
| Docker + WSL2 + 几个容器 | 中 | ✅ 16GB 够，注意不要同时开太多 |
| Ollama 3B-7B 量化模型 | 中 | ✅ GTX 1650 4GB 能装 |
| nanoGPT / PyTorch 训练 | 中 | ✅ 小规模可以 |
| Ollama + Docker + VS Code 同时 | 高 | ⚠️ 16GB 有点紧 |
| 编译大型项目（如 LLVM） | 高 | ⚠️ 慢，但不会挂 |

### 必须优先处理

1. **C 盘清理**（最高优先级）——只剩 10 GB，无法正常安装软件、无法 Windows 更新
2. **电源线注意**——没电池时拔插头 = 直接断电，可能损坏 SSD
3. **物理除尘**（建议）——7 年没清理的话，满载可能撞温度墙降频

## 执行步骤

### 第 0 步：网络连通性检查（已确认 ✅）

| 目标 | 端口 | 结果 |
|------|------|------|
| `github.com` HTTPS | 443 | ✅ 通 |
| `github.com` SSH | 22 | ✅ 通 |

GitHub 当前可直接访问，无需配 SwitchHosts。SwitchHosts 在机器上有残留文件（`%APPDATA%\switchhosts\`），如果日后 GitHub 连不上再启用。备用方案：

- SwitchHosts v3.3.12 安装包在 `Downloads\Compressed\SwitchHosts-win32-ia32_v3.3.12.5349.zip`
- 使用时解压运行，添加 GitHub 的 hosts 规则即可（如 `140.82.114.4 github.com`）
- 也可以直接用主流 DNS（114.114.114.114 或 8.8.8.8）+ `ipconfig /flushdns` 解决大部分问题

### 第 1 步：确认 GitHub 身份信息

询问用户提供：
- GitHub 用户名
- GitHub 注册邮箱

### 第 2 步：安装 Git

```powershell
winget install Git.Git
```
安装完成后刷新 PATH，验证 `git --version`。

### 第 3 步：配置 Git 全局信息

```powershell
git config --global user.name "<用户名>"
git config --global user.email "<邮箱>"
```

### 第 4 步：生成 SSH 密钥对

```powershell
ssh-keygen -t ed25519 -C "<邮箱>"
```
- 默认路径：`~/.ssh/id_ed25519`
- 输出公钥，提示用户去 GitHub → Settings → SSH and GPG keys → New SSH Key 粘贴

### 第 5 步：创建仓库目录结构

在 `C:\Users\Jasper\` 下创建 `windows-setup\` 目录，结构如下：

```
windows-setup/
├── README.md                   ← 仓库总览，说明这是什么、怎么用
├── AGENT.md                    ← AI 编码助手指引（给 Claude Code/Cursor 看）
├── PLAN.md                     ← 这份计划文档（执行历史 + 决策记录）
├── checklist.md                ← 核心：Windows 优化全清单（按分类）
├── scripts/
│   ├── disable-updates.reg     ← 暂停更新 100 年 + 禁用更新服务
│   ├── classic-context-menu.reg ← 恢复 Win10 经典右键菜单
│   ├── privacy-tweaks.reg      ← 关闭遥测/广告 ID/活动历史
│   ├── lock-screen-ads.reg     ← 关闭锁屏广告、搜索新闻
│   ├── tweaks.ps1              ← 一键执行所有注册表修改的脚本
│   └── check-cuda.ps1          ← 验证 CUDA 安装状态的脚本
├── dotfiles/
│   ├── Microsoft.PowerShell_profile.ps1  ← PowerShell 配置（Oh My Posh + fzf + zoxide）
│   ├── starship.toml                     ← Starship 提示符配置（备选）
│   ├── .wezterm.lua                      ← WezTerm 终端配置
│   ├── windows-terminal-settings.json    ← Windows Terminal 配置
│   └── nvim/                             ← LazyVim 配置目录
│       └── (git clone LazyVim/starter → 自定义覆盖)
├── notes/
│   ├── windows-versions.md     ← 各版本对比、推荐版本说明
│   ├── gpu-setup.md            ← GTX 1650 开发利用指南
│   └── dev-toolchain.md        ← 开发工具链对照表（Mac vs Windows 对标）

### 第 6 步：编写核心文件

#### README.md
- 仓库定位：Windows 个人优化清单 + dotfiles
- 适用环境：Windows 11 Pro, 16GB RAM, i5-9300H, GTX 1650
- 快速开始说明
- 文件导航

#### AGENT.md
给 AI 编码助手的项目上下文，内容包括：
- **项目简介**：这是什么仓库，解决什么问题
- **项目结构**：目录说明速览
- **文件约定**：`.reg` 文件是注册表脚本（不要随便双击执行）、`.ps1` 是 PowerShell 脚本、dotfiles 下是配置文件
- **硬约束**：只针对 Windows 11 Pro 给出建议、不要建议 macOS 工具、考虑 GTX 1650 4GB 显存限制
- **用户偏好**：从对话中提取的关键偏好（停更新但不卸载 Defender、Pro 版不升级企业版、中文环境）

#### checklist.md（主清单）
按以下分类组织：

| 分类 | 条目 |
|------|------|
| 🔴 更新控制 | 注册表暂停 100 年、禁用更新服务、任务计划禁止唤醒 |
| 🔒 隐私 & 遥测 | 诊断数据最低、关广告 ID、关活动历史、关位置 |
| 🧹 预装垃圾 | Winhance 一键卸载、关小组件、移除 Edge |
| 🖥️ UI 修复 | 经典右键菜单、任务栏不合并、关搜索新闻 |
| 🔤 字体 & 显示 | ClearType 校准、整数倍缩放、JetBrainsMono Nerd Font |
| 🕐 时间同步 | 换阿里云 NTP、关自动时区 |
| 🎮 GPU 利用 | CUDA 开发环境、NVENC 硬件编码、Ollama 本地 LLM、终端/浏览器 GPU 加速、WSL2 GPU 直通、nanoGPT |
| 🔧 开发环境 | Git、VS Code、WSL2、PowerShell 7、Scoop/winget、WezTerm/Win Terminal |
| ⚡ 现代 CLI | eza(ls)、bat(cat)、ripgrep(rg/grep)、fd(find)、zoxide(cd)、delta(diff)、dust(du)、duf(df)、bottom(top/btm)、procs(ps)、sd(sed)、fzf、tldr(man)、xh(curl)、jq(JSON)、mcfly(Ctrl-R)、gping(ping)、glow(markdown)、difftastic(diff) |
| 📝 编辑器 | **Neovim + LazyVim**（同 Mac）、ripgrep、fd、lazygit、gcc 依赖链 |
| 🎨 Shell 提示 | Oh My Posh 或 Starship、fzf、zoxide、Terminal-Icons |
| 🎨 桌面美化 | Windhawk、GlazeWM/Komorebi、ExplorerPatcher |
| ⚙️ 系统版本 | 锁定 25H2、安全更新策略 |

每条目标注：优先级（🔴/🟡/🟢）、操作方法、是否已配置

#### scripts/ 目录
- 每个 `.reg` 文件带注释说明用途
- `tweaks.ps1` 作为聚合脚本，可一键执行所有 reg 导入

#### dotfiles/ 目录
- PowerShell Profile：Oh My Posh 初始化、fzf 集成、zoxide、别名
- WezTerm 配置：字体、配色、键位（初始用占位/默认配置）
- Windows Terminal settings.json（如果用户需要）

#### notes/windows-versions.md
- 各版本对比表
- 当前推荐版本及原因
- 更新策略（安全更新 vs 功能更新）

#### notes/gpu-setup.md
GTX 1650（4GB, Turing, 896 CUDA Cores）可做的事：

| 方向 | 具体内容 | 适合性 |
|------|----------|--------|
| **CUDA 开发** | 装 CUDA Toolkit + cuDNN，跑 PyTorch/TensorFlow 小规模训练 | ✅ 4GB 够入门模型 |
| **本地 LLM** | Ollama 跑 1.5B-7B 模型，4GB 能装下 Q8_0 / Q4_K_M 量化版 | ✅ Qwen2.5、Llama 3.2 都行 |
| **nanoGPT** | 跑 Karpathy 的 nanoGPT 训练小模型 | ✅ 完全够 |
| **NVENC 编码** | FFmpeg/OBS 硬件加速录屏、转码，不占 CPU | ✅ Turing NVENC 画质不错 |
| **终端 GPU 加速** | Windows Terminal / WezTerm 文字渲染走 GPU | ✅ 自动启用 |
| **浏览器加速** | Chrome/Edge 强制使用独显渲染 | ✅ 需在 NVIDIA 控制面板设置 |
| **WSL2 GPU** | WSL2 内直接用 CUDA，Docker 也能分 GPU | ✅ 需装对应驱动 |
| **游戏** | 轻度游戏，DLSS 不支持（1650 无 Tensor Core） | ⚠️ 入门级 |

- CUDA 安装步骤（驱动版本检查 → CUDA Toolkit → cuDNN → 验证）
- Ollama 安装及推荐模型列表
- WSL2 GPU 直通配置方法

#### notes/dev-toolchain.md
Mac → Windows 开发工具对标表：

| 用途 | Mac | Windows |
|------|-----|---------|
| 终端 | Ghostty | Windows Terminal / WezTerm |
| 编辑器 | LazyVim | Neovim + LazyVim（完全一样） |
| Shell | zsh / fish | PowerShell 7 |
| 包管理 | Homebrew | Scoop + winget |
| 字体 | 等宽字体 | JetBrainsMono Nerd Font |
| 提示符 | — | Oh My Posh 或 Starship |

LazyVim 一键安装步骤：
```powershell
scoop install neovim ripgrep fd lazygit gcc
git clone https://github.com/LazyVim/starter $env:LOCALAPPDATA\nvim
nvim  # 首次启动自动装插件
```

### 第 7 步：初始化 Git 仓库并推送

```powershell
cd C:\Users\Jasper\windows-setup
git init
git add .
git commit -m "初始提交：Windows 优化清单 + dotfiles"
```

在 GitHub 上创建同名仓库后：
```powershell
git remote add origin git@github.com:<用户名>/windows-setup.git
git branch -M main
git push -u origin main
```

### 第 8 步：验证

- 确认 GitHub 仓库页面可见
- 确认 README 正确渲染
- 确认 SSH 密钥认证正常（后续推送无需密码）

## 验证方式

1. `git --version` 返回正常版本号
2. `ssh -T git@github.com` 返回认证成功
3. 浏览器打开 `github.com/<用户名>/windows-setup` 可见所有文件
4. 在另一台机器上能 `git clone` 该仓库