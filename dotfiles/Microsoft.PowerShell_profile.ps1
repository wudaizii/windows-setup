# ============================================
# PowerShell Profile — Dell Inspiron 7590
# 放置路径: $PROFILE (通常为 C:\Users\<用户名>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1)
# ============================================

# --- Oh My Posh 提示符（安装后取消注释） ---
# oh-my-posh --init --shell pwsh --config "$env:POSH_THEMES_PATH/catppuccin_mocha.omp.json" | Invoke-Expression

# --- Starship 提示符（备选，安装后取消注释） ---
# Invoke-Expression (&starship init powershell)

# --- fzf 集成（安装 PSFzf 模块后取消注释） ---
# Import-Module PSFzf
# Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# --- zoxide 智能跳转（安装后取消注释） ---
# Invoke-Expression (& { (zoxide init powershell | Out-String) })

# --- Terminal-Icons 图标（安装后取消注释） ---
# Import-Module Terminal-Icons

# --- PSReadLine 优化 ---
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineKeyHandler -Key Tab -Function Complete

# --- 现代 CLI 别名 ---
# 安装对应工具后取消注释：
# Set-Alias ls eza
# Set-Alias cat bat
# Set-Alias grep rg
# Set-Alias find fd
# Set-Alias du dust
# Set-Alias top btm
# Set-Alias ps procs
# Set-Alias diff difftastic
# Set-Alias man tldr
# Set-Alias curl xh
# Set-Alias ping gping
# Set-Alias sed sd

# --- 实用函数 ---
function which { Get-Command $args[0] | Select-Object -ExpandProperty Source }
function gs { git status }
function gc { git commit -m "$args" }
function gp { git push }
function gl { git log --oneline -20 }

# --- 欢迎 ---
Write-Host "🪟 Dell Inspiron 7590 | Win11 Pro | $(Get-Date -Format 'HH:mm')" -ForegroundColor Cyan