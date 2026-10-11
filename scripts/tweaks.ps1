# ============================================
# Windows 一键优化脚本
# 以管理员身份运行： .\tweaks.ps1
# ============================================

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Windows 一键优化" -ForegroundColor Cyan
Write-Host "  机型: Dell Inspiron 7590" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 检查管理员权限
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "[错误] 请以管理员身份运行此脚本" -ForegroundColor Red
    pause
    exit 1
}

$regFiles = @(
    "disable-updates.reg",
    "classic-context-menu.reg",
    "privacy-tweaks.reg",
    "lock-screen-ads.reg"
)

foreach ($file in $regFiles) {
    $path = Join-Path $ScriptDir $file
    if (Test-Path $path) {
        Write-Host "[导入] $file" -ForegroundColor Yellow
        reg import "`"$path`"" 2>&1 | Out-Null
        Write-Host "  -> 完成" -ForegroundColor Green
    } else {
        Write-Host "[跳过] $file 未找到" -ForegroundColor DarkGray
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  导入完成！建议重启资源管理器或注销" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
pause