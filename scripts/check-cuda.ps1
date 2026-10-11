# ============================================
# CUDA 安装状态检查脚本
# 用于验证 GPU 开发环境是否正确配置
# ============================================

Write-Host "=== NVIDIA 驱动 ==="
try {
    $driver = Get-CimInstance Win32_VideoController | Where-Object { $_.Name -match "NVIDIA" }
    Write-Host "驱动: $($driver.Name)"
    Write-Host "版本: $($driver.DriverVersion)"
} catch {
    Write-Host "未检测到 NVIDIA 驱动" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== CUDA Toolkit ==="
$nvcc = Get-Command nvcc -ErrorAction SilentlyContinue
if ($nvcc) {
    & nvcc --version 2>&1 | Select-Object -First 3
} else {
    Write-Host "nvcc 未安装或在 PATH 中找不到" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== GPU 显存 ==="
try {
    nvidia-smi --query-gpu=memory.total,memory.used,memory.free --format=csv 2>&1
} catch {
    Write-Host "nvidia-smi 不可用" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Ollama ==="
$ollama = Get-Command ollama -ErrorAction SilentlyContinue
if ($ollama) {
    ollama list 2>&1
} else {
    Write-Host "Ollama 未安装" -ForegroundColor Yellow
}