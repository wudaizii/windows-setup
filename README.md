# windows-setup

🪟 Windows 全栈优化清单 & 个人配置（Dell Inspiron 7590）

## 适用环境

| 组件 | 型号 |
|------|------|
| 机型 | Dell Inspiron 7590（BIOS 1.3.0） |
| OS | Windows 11 Pro, Build 26200 |
| CPU | Intel i5-9300H, 4C8T @ 2.40GHz |
| 内存 | 16 GB DDR4-2667（2×8GB） |
| 独显 | NVIDIA GeForce GTX 1650, 4 GB |
| SSD | WD PC SN520 NVMe 512GB |
| 电池 | ⚠️ 已拆除，仅 AC 供电 |

## 这是什么

一份照着做就能让 Windows 11 Pro 变得不烦人的清单，加上终端/编辑器/PowerShell 的 dotfiles 配置。

## 文件导航

| 文件 | 用途 |
|------|------|
| `checklist.md` | 12 个分类的优化清单，标注了优先级和操作步骤 |
| `scripts/` | 注册表脚本（`.reg`）和 PowerShell 自动化脚本 |
| `dotfiles/` | PowerShell Profile、WezTerm、Windows Terminal 配置 |
| `notes/` | Windows 版本对比、GPU 开发指南、Mac ↔ Win 工具对照表 |
| `AGENT.md` | 给 AI 编码助手的项目上下文 |
| `PLAN.md` | 项目执行计划和决策记录 |

## 快速开始

```powershell
# 1. 导入所有注册表优化（管理员终端）
cd scripts
.\tweaks.ps1

# 2. 安装 PowerShell Profile
copy dotfiles\Microsoft.PowerShell_profile.ps1 $PROFILE

# 3. 安装 Scoop 包管理器
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

# 4. 批量安装现代 CLI 工具
scoop install eza bat ripgrep fd zoxide delta dust duf bottom procs sd fzf tldr xh jq mcfly gping glow
```

## 分类概览

- 🔴 更新控制
- 🔒 隐私 & 遥测
- 🧹 预装垃圾
- 🖥️ UI 修复
- 🔤 字体 & 显示
- 🕐 时间同步
- 🎮 GPU 利用
- 🔧 开发环境
- ⚡ 现代 CLI
- 📝 编辑器
- 🎨 Shell 提示 & 桌面美化
- ⚙️ 系统版本