# AGENT.md — AI 编码助手项目指引

## 项目简介

这是一个 Windows 个人优化清单 + dotfiles 配置仓库，针对一台 **Dell Inspiron 7590** 笔记本（Windows 11 Pro）。

## 项目结构

```
windows-setup/
├── README.md        — 给人看的项目说明
├── AGENT.md         — 给 AI 看的项目上下文（你正在读这个）
├── PLAN.md          — 执行计划与决策记录
├── checklist.md     — 12 类优化清单（核心文件）
├── scripts/         — .reg 注册表脚本 + .ps1 PowerShell 脚本
├── dotfiles/        — PowerShell Profile + 终端/编辑器配置
└── notes/           — 版本对比、GPU 指南、工具对照表
```

## 文件约定

| 扩展名 | 说明 | 注意 |
|--------|------|------|
| `.reg` | Windows 注册表导入文件 | **不能随便双击执行**——先在 regedit 里备份对应注册表路径 |
| `.ps1` | PowerShell 脚本 | 需管理员权限运行 `tweaks.ps1` |
| `.lua` | 终端/编辑器配置 | WezTerm 或 Neovim 的 Lua 配置 |
| `.json` | 终端配置 | Windows Terminal settings.json |
| `.toml` | 提示符配置 | Starship 的配置文件 |

## 硬约束

- **只针对 Windows 11 Pro**——不要建议 macOS 或 Linux 专用工具
- **GPU 显存 4 GB**——推荐模型/工具时考虑 GTX 1650 的 4GB VRAM 限制
- **内存 16 GB**——避免建议需要 32GB+ 的方案
- **电池已拆除**——需要考虑意外断电对 SSD 的风险
- **SSD 空间紧张**——仅 10GB 空闲，推荐工具时优先轻量方案
- **网络环境**——GitHub 直连可能较慢，优先建议通过 npm 镜像、清华源等国内源安装

## 用户偏好

- 停止 Windows 自动更新，但保留 Windows Defender
- 使用 Windows 11 Pro（专业版），不升级企业版/Server 版
- 中文环境，命令行和系统语言为中文
- 偏好开源工具和脚本化配置
- 开发工作流对标 Mac 体验（LazyVim、Ghostty→WezTerm、Homebrew→Scoop）
- 使用 ChatGPT/Claude Code 等 AI 编码助手

## 参考来源

- ibraheemdev/modern-unix — 现代 CLI 工具推荐
- 521xueweihan/GitHub520 — GitHub hosts 加速
- Chris Titus WinUtil — Windows 系统优化工具箱